from flask import Flask, render_template, request, abort, redirect, session, jsonify
import psycopg2
import psycopg2.extras
import os

app = Flask(__name__)

# simple session setup for role control
app.secret_key = "repertoar-dev-key"

# default session values for all visitors
@app.before_request
def set_default_session_values():
    if "role" not in session:
        session["role"] = "viewer"

    if "language" not in session:
        session["language"] = "hr"

    if "market" not in session:
        session["market"] = "hr"

    if "auto_lock" not in session:
        session["auto_lock"] = "off"

# ---------- SESSION HELPERS ----------

def get_language():
    return session.get("language", "hr")

def get_market():
    return session.get("market", "hr")

# ---------- MARKET FILTER CONFIG ----------
MARKET_FILTERS = {
    "hr": {
        "origin": ["Domaće", "Strano"],
        "vocal": ["Muško", "Žensko", "Duet"],
        "tempo": ["Spora", "Srednja", "Brza"],
        "special": ["Instrumental"],
        "genres_mode": "local"
    },
    "international": {
        "origin": ["Domestic", "International"],
        "vocal": ["Male", "Female", "Duet"],
        "tempo": ["Slow", "Medium", "Fast"],
        "special": ["Instrumental"],
        "genres_mode": "genre"
    }
}

def get_market_filters():
    market = get_market()
    return MARKET_FILTERS.get(market, MARKET_FILTERS["hr"])

# ---------- GLOBAL TEMPLATE VARIABLES ----------
@app.context_processor
def inject_globals():
    return {
        "lang": get_language(),
        "market": get_market(),
        "market_filters": get_market_filters(),
        "auto_lock": session.get("auto_lock", "off")
    }

# ---------- TRANSLATIONS ----------
TRANSLATIONS = {

    # MAIN NAV
    "home": {
        "hr": "Početna",
        "en": "Home",
        "de": "Start"
    },
    "repertoar": {
        "hr": "Repertoar",
        "en": "Repertoire",
        "de": "Repertoire"
    },
    "mixes": {
        "hr": "Miksevi",
        "en": "Mixes",
        "de": "Mixes"
    },
    "setlists": {
        "hr": "Set liste",
        "en": "Setlists",
        "de": "Setlists"
    },
    "rehearsals": {
        "hr": "Probe",
        "en": "Rehearsals",
        "de": "Proben"
    },
    "settings": {
        "hr": "Postavke",
        "en": "Settings",
        "de": "Einstellungen"
    },

    # COMMON ACTIONS
    "add": {
        "hr": "Dodaj",
        "en": "Add",
        "de": "Hinzufügen"
    },
    "edit": {
        "hr": "Uredi",
        "en": "Edit",
        "de": "Bearbeiten"
    },
    "delete": {
        "hr": "Obriši",
        "en": "Delete",
        "de": "Löschen"
    },
    "save": {
        "hr": "Spremi",
        "en": "Save",
        "de": "Speichern"
    },
    "cancel": {
        "hr": "Odustani",
        "en": "Cancel",
        "de": "Abbrechen"
    },

    # FILTER / SEARCH
    "filter": {
        "hr": "Filter",
        "en": "Filter",
        "de": "Filter"
    },
    "search": {
        "hr": "Pretraži",
        "en": "Search",
        "de": "Suche"
    },

    # SETTINGS SECTIONS
    "theme": {
        "hr": "Tema",
        "en": "Theme",
        "de": "Design"
    },
    "language": {
        "hr": "Jezik",
        "en": "Language",
        "de": "Sprache"
    },
    "market": {
        "hr": "Tržište",
        "en": "Market",
        "de": "Markt"
    },

    # OTHER
    "logout": {
        "hr": "Odjava",
        "en": "Logout",
        "de": "Abmelden"
    }
}

def t(key):
    lang = get_language()
    if key in TRANSLATIONS and lang in TRANSLATIONS[key]:
        return TRANSLATIONS[key][lang]
    return key

# expose translation helper to templates
@app.context_processor
def inject_translator():
    return {"t": t}

# helper for admin-only routes
def require_admin():
    if session.get("role") != "admin":
        abort(403)

# ---------- ADMIN MODE (DEV / TEST) ----------
@app.route("/admin")
def admin_mode():
    session["role"] = "admin"
    return "Admin mode ON"

# ---------- VIEWER MODE ----------
@app.route("/viewer")
def viewer_mode():
    session["role"] = "viewer"
    return "Viewer mode ON"

# ---------- SETTINGS: LANGUAGE ----------
@app.route("/settings/language/<lang>", methods=["POST"])
def set_language(lang):
    if lang not in ["hr", "en", "de"]:
        abort(400)

    session["language"] = lang
    return ("", 204)


# ---------- SETTINGS: MARKET ----------
@app.route("/settings/market/<market>", methods=["POST"])
def set_market(market):
    if market not in ["hr", "international"]:
        abort(400)

    session["market"] = market
    return ("", 204)

# ---------- SETTINGS: AUTO LOCK ----------
@app.route("/settings/autolock/<mode>", methods=["POST"])
def set_auto_lock(mode):
    if mode not in ["off", "5", "15"]:
        abort(400)

    session["auto_lock"] = mode
    return ("", 204)

def nav_ctx(title=None, back_url=None, mode="library", show_back=True, show_settings=True):
    return {
        "title": title,
        "back_url": back_url,
        "show_back": show_back,
        "mode": mode,
        "show_settings": show_settings
    }


# ---------- DB ----------
class DB:
    def __init__(self, conn):
        self.conn = conn

    def execute(self, query, params=None):
        # convert SQLite ? placeholders to PostgreSQL %s
        query = query.replace("?", "%s")

        cur = self.conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        cur.execute(query, params or [])
        return cur

    def commit(self):
        self.conn.commit()


def get_db():
    # Support Render / production DATABASE_URL
    database_url = os.environ.get("DATABASE_URL")

    if database_url:
        conn = psycopg2.connect(database_url)
    else:
        conn = psycopg2.connect(
            dbname=os.environ.get("PGDATABASE", "repertoar"),
            user=os.environ.get("PGUSER", "markomarjanovic"),
            password=os.environ.get("PGPASSWORD", ""),
            host=os.environ.get("PGHOST", "localhost"),
            port=os.environ.get("PGPORT", "5432"),
        )

    return DB(conn)


# ---------- HOME ----------
@app.route("/")
def home():
    db = get_db()

    song_count = db.execute(
        "SELECT COUNT(*) AS count FROM songs WHERE status='repertoar'"
    ).fetchone()["count"]

    mix_count = db.execute(
        "SELECT COUNT(*) AS count FROM mixes"
    ).fetchone()["count"]

    rehearsal_count = db.execute(
        "SELECT COUNT(*) AS count FROM rehearsals WHERE status='planned'"
    ).fetchone()["count"]

    setlist_count = db.execute(
        "SELECT COUNT(*) AS count FROM setlists"
    ).fetchone()["count"]

    return render_template(
        "home.html",
        song_count=song_count,
        mix_count=mix_count,
        rehearsal_count=rehearsal_count,
        setlist_count=setlist_count,
        nav=nav_ctx(
            title=None,
            back_url=None,
            mode="library",
            show_back=False
        )   
    )

# ---------- SONG STATS (SETTINGS PANEL) ----------
@app.route("/api/song_stats")
def api_song_stats():
    db = get_db()

    stats = db.execute(
        "SELECT * FROM v_home_stats"
    ).fetchone()

    mix_count = db.execute(
        "SELECT COUNT(*) AS count FROM mixes"
    ).fetchone()["count"]

    setlist_count = db.execute(
        "SELECT COUNT(*) AS count FROM setlists"
    ).fetchone()["count"]

    rehearsal_count = db.execute(
        "SELECT COUNT(*) AS count FROM rehearsals"
    ).fetchone()["count"]

    tempo_stats = db.execute(
        """
        SELECT
            SUM(CASE WHEN tempo = 'Spora' THEN 1 ELSE 0 END) AS tempo_spora,
            SUM(CASE WHEN tempo = 'Srednja' THEN 1 ELSE 0 END) AS tempo_srednja,
            SUM(CASE WHEN tempo = 'Brza' THEN 1 ELSE 0 END) AS tempo_brza
        FROM songs
        WHERE status='repertoar'
        """
    ).fetchone()

    # genre statistics (from view)
    genres = db.execute(
        "SELECT genre, genre_count AS count FROM v_brojzanr ORDER BY genre_count DESC"
    ).fetchall()

    # region statistics
    regions = db.execute(
        """
        SELECT region, COUNT(*) AS count
        FROM songs
        WHERE status='repertoar' AND region IS NOT NULL AND region != ''
        GROUP BY region
        ORDER BY count DESC
        """
    ).fetchall()

    return jsonify({
        "total_songs": stats["total_songs"],
        "tempo_spora": tempo_stats["tempo_spora"],
        "tempo_srednja": tempo_stats["tempo_srednja"],
        "tempo_brza": tempo_stats["tempo_brza"],
        "total_domace": stats["total_domace"],
        "total_strano": stats["total_strano"],
        "total_musko": stats["total_musko"],
        "total_zensko": stats["total_zensko"],
        "total_instrumental": stats["total_instrumental"],
        "total_mixes": mix_count,
        "total_setlists": setlist_count,
        "total_rehearsals": rehearsal_count,
        "genres": genres,
        "regions": regions
    })

# ---------- REPERTOAR ----------
@app.route("/repertoar")
def repertoar():
    db = get_db()

    filters = {
        "origin": request.args.get("origin"),
        "vocal": request.args.get("vocal"),
        "tempo": request.args.get("tempo"),
        "genre": request.args.get("genre"),
        "regija": request.args.get("regija"),
        "theme": request.args.get("theme"),
        "mix": request.args.get("mix"),
        "instrumental": request.args.get("instrumental"),
        "q": request.args.get("q")
    }

    query = """
        SELECT songs.*, mixes.name AS mix_name
        FROM songs
        LEFT JOIN mixes ON songs.mix_id = mixes.id
        WHERE songs.status = 'repertoar'
    """
    params = []

    for key, col in [
        ("origin", "origin"),
        ("vocal", "vocal"),
        ("tempo", "tempo"),
        ("genre", "genre"),
        ("regija", "region"),
        ("theme", "theme"),
    ]:
        if filters[key]:
            query += f" AND songs.{col} = ?"
            params.append(filters[key])
        
    if filters["mix"] == "1":
        query += " AND songs.mix_id IS NOT NULL"

    if filters["instrumental"] == "1":
        query += " AND songs.is_instrumental = 1"

    if filters["q"]:
        query += " AND (songs.title LIKE ? OR songs.artist LIKE ?)"
        params += [f"%{filters['q']}%"] * 2

    query += " ORDER BY LOWER(songs.title)"

    songs = db.execute(query, params).fetchall()

    return render_template(
        "repertoar.html",
        songs=songs,
        filters=filters,
        filters_open=request.args.get("filters") == "1",
        nav=nav_ctx(
                title="Repertoar",
                back_url="/",
                mode="library",
                show_back=True
    )
)

# ---------- SONG DETAIL ----------
@app.route("/song/<int:song_id>")
def song_detail(song_id):
    db = get_db()

    song = db.execute("""
        SELECT songs.*, mixes.name AS mix_name
        FROM songs
        LEFT JOIN mixes ON songs.mix_id = mixes.id
        WHERE songs.id = ?
    """, (song_id,)).fetchone()

    if not song:
        abort(404)

    from_param = request.args.get("from")
    set_id = request.args.get("set")

    # -------------------------------------------------
    # BACK LOGIKA (OSTAJE TVOJA)
    # -------------------------------------------------

    if from_param == "setlist" and set_id:
        back_url = f"/setlist/{set_id}"

    elif from_param and from_param.startswith("/probe/"):
        back_url = from_param

    elif from_param:
        back_url = from_param

    else:
        back_url = "/repertoar"

    # -------------------------------------------------
    # 🔥 SWIPE SUPPORT (DODANO)
    # -------------------------------------------------

    set_items = []
    current_index = None

    if from_param == "setlist" and set_id:

        items = db.execute("""
            SELECT item_type, item_id
            FROM setlist_items
            WHERE setlist_id=?
            ORDER BY position
        """, (set_id,)).fetchall()

        for i, item in enumerate(items):
            set_items.append({
                "type": item["item_type"],
                "id": item["item_id"]
            })

            if item["item_type"] == "song" and item["item_id"] == song_id:
                current_index = i

    return render_template(
    "song.html",
    song=song,
    nav=nav_ctx(
        title=song["title"],
        back_url=back_url,
        mode="library",
        show_back=True,
        show_settings=False
    ),
    set_items=set_items,
    current_index=current_index
)


# ---------- ADD SONG (REPERTOAR) ----------
@app.route("/song/add", methods=["GET", "POST"])
def song_add():
    db = get_db()

    if request.method == "POST":

        planned_mix = request.form.get("planned_mix")
        planned_mix_new = request.form.get("planned_mix_new")
        mix_order = request.form.get("mix_order")

        final_planned_mix = planned_mix_new or planned_mix

        mix_id = None

        # Ako je mix definiran → provjeri postoji li
        if final_planned_mix:
            mix = db.execute(
                "SELECT id FROM mixes WHERE name = ?",
                (final_planned_mix,)
            ).fetchone()

            if not mix:
                cur = db.execute(
                    "INSERT INTO mixes (name) VALUES (?) RETURNING id",
                    (final_planned_mix,)
                )
                mix_id = cur.fetchone()["id"]
            else:
                mix_id = mix["id"]

        db.execute("""
            INSERT INTO songs (
                title, artist, key, tempo, genre, region, vocal,
                origin, theme, lyrics, is_instrumental,
                mix_id, mix_order, status
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'repertoar')
        """, (
            request.form.get("title"),
            request.form.get("artist"),
            request.form.get("key"),
            request.form.get("tempo"),
            request.form.get("genre"),
            request.form.get("region"),
            request.form.get("vocal"),
            request.form.get("origin"),
            request.form.get("theme"),
            request.form.get("lyrics"),
            1 if request.form.get("is_instrumental") else 0,
            mix_id,
            int(mix_order) if mix_order else None
        ))

        db.commit()
        return redirect("/repertoar")

    mixes = db.execute("SELECT name FROM mixes ORDER BY name").fetchall()

    return render_template(
        "song_add.html",
        mixes=mixes,
        nav=nav_ctx(
            title="Nova pjesma",
            back_url="/repertoar",
            mode="library",
            show_back=True
        )
    )

# ---------- EDIT SONG (REPERTOAR ONLY) ----------
@app.route("/repertoar/<int:song_id>/edit", methods=["GET", "POST"])
def edit_song_repertoar(song_id):
    db = get_db()
    require_admin()

    # 🔹 Dohvati pjesmu + ime mixa (BITNO!)
    song = db.execute("""
        SELECT songs.*, mixes.name AS mix_name
        FROM songs
        LEFT JOIN mixes ON songs.mix_id = mixes.id
        WHERE songs.id=? AND songs.status='repertoar'
    """, (song_id,)).fetchone()

    if not song:
        abort(404)

    if request.method == "POST":

        planned_mix = request.form.get("planned_mix")
        planned_mix_new = request.form.get("planned_mix_new")
        mix_order = request.form.get("mix_order")

        final_planned_mix = planned_mix_new or planned_mix
        mix_id = None

        # 🔹 Ako je definiran mix → pronađi ili kreiraj
        if final_planned_mix:
            mix = db.execute(
                "SELECT id FROM mixes WHERE name=?",
                (final_planned_mix,)
            ).fetchone()

            if not mix:
                cur = db.execute(
                    "INSERT INTO mixes (name) VALUES (?) RETURNING id",
                    (final_planned_mix,)
                )
                mix_id = cur.fetchone()["id"]
            else:
                mix_id = mix["id"]

        db.execute("""
            UPDATE songs
            SET title=?,
                artist=?,
                key=?,
                tempo=?,
                genre=?,
                region=?,
                vocal=?,
                origin=?,
                theme=?,
                lyrics=?,
                is_instrumental=?,
                mix_id=?,
                mix_order=?
            WHERE id=?
        """, (
            request.form.get("title"),
            request.form.get("artist"),
            request.form.get("key"),
            request.form.get("tempo"),
            request.form.get("genre"),
            request.form.get("region"),
            request.form.get("vocal"),
            request.form.get("origin"),
            request.form.get("theme"),
            request.form.get("lyrics"),
            1 if request.form.get("is_instrumental") else 0,
            mix_id,
            int(mix_order) if mix_order else None,
            song_id
        ))

        db.commit()
        return redirect("/repertoar")

    mixes = db.execute("SELECT name FROM mixes ORDER BY name").fetchall()
    artists = db.execute("SELECT DISTINCT artist FROM songs ORDER BY artist").fetchall()

    return render_template(
    "song_edit.html",
    song=song,
    mixes=mixes,
    artists=artists,
    nav=nav_ctx(
        title="Uredi pjesmu",
        back_url="/repertoar",
        mode="library",
        show_back=True
    )
)


# ---------- EDIT SONG (FROM PROBE) ----------
@app.route("/song/<int:song_id>/edit", methods=["GET", "POST"])
def edit_song(song_id):
    db = get_db()
    song = db.execute(
        "SELECT * FROM songs WHERE id = ?", (song_id,)
    ).fetchone()
    if not song:
        abort(404)

    rehearsal = db.execute("""
        SELECT r.*
        FROM rehearsals r
        JOIN rehearsal_songs rs ON rs.rehearsal_id = r.id
        WHERE rs.song_id = ?
        LIMIT 1
    """, (song_id,)).fetchone()

    if not rehearsal:
        abort(400)

    if request.method == "POST":
        db.execute("""
            UPDATE songs
            SET
                title = ?,
                artist = ?,
                key = ?,
                tempo = ?,
                genre = ?,
                region = ?,
                vocal = ?,
                origin = ?,
                theme = ?,
                lyrics = ?,
                is_instrumental = ?,
                planned_mix = ?,
                mix_order = ?
            WHERE id = ?
        """, (
            request.form.get("title"),
            request.form.get("artist"),
            request.form.get("key"),
            request.form.get("tempo"),
            request.form.get("genre"),
            request.form.get("region"),
            request.form.get("vocal"),
            request.form.get("origin"),
            request.form.get("theme"),
            request.form.get("lyrics"),
            1 if request.form.get("is_instrumental") else 0,
            request.form.get("planned_mix"),
            int(request.form.get("mix_order")) if request.form.get("mix_order") else None,
            song_id
        ))

        db.commit()
        return redirect(f"/probe/{rehearsal['id']}")

    songs = db.execute("""
        SELECT s.*
        FROM songs s
        JOIN rehearsal_songs rs ON rs.song_id = s.id
        WHERE rs.rehearsal_id = ?
        ORDER BY s.title
    """, (rehearsal["id"],)).fetchall()

    mixes = db.execute("SELECT name FROM mixes ORDER BY name").fetchall()
    artists = db.execute("SELECT DISTINCT artist FROM songs ORDER BY artist").fetchall()

    return render_template(
    "probe_detail.html",
    rehearsal=rehearsal,
    songs=songs,
    mixes=mixes,
    artists=artists,
    edit_song=song,
    nav=nav_ctx(
        title="Uredi pjesmu",
        back_url=f"/probe/{rehearsal['id']}",
        mode="rehearsal",
        show_back=True
    )
)

# ---------- MIXES ----------
@app.route("/mixes")
def mixes():
    db = get_db()

    filters = {
        "origin": request.args.get("origin"),
        "vocal": request.args.get("vocal"),
        "tempo": request.args.get("tempo"),
        "genre": request.args.get("genre"),
        "regija": request.args.get("regija"),
        "instrumental": request.args.get("instrumental"),
        "q": request.args.get("q")
    }

    query = """
        SELECT
            m.id,
            m.name,

            (
                SELECT COUNT(*)
                FROM songs s2
                WHERE s2.mix_id = m.id
                  AND s2.status = 'repertoar'
            ) AS song_count,

            (
                SELECT STRING_AGG(title, ', ')
                FROM (
                    SELECT s2.title
                    FROM songs s2
                    WHERE s2.mix_id = m.id
                      AND s2.status = 'repertoar'
                    ORDER BY s2.mix_order ASC
                ) AS agg
            ) AS song_titles,

            (
                SELECT MIN(s2.key)
                FROM songs s2
                WHERE s2.mix_id = m.id
                  AND s2.status = 'repertoar'
            ) AS mix_key,

            m.created_at,

            CASE
                WHEN m.created_at IS NOT NULL
                 AND EXTRACT(EPOCH FROM (NOW() - CAST(m.created_at AS timestamptz))) < 86400
                THEN 1
                ELSE 0
            END AS is_new

        FROM mixes m
        WHERE 1=1
    """

    params = []

    # FILTERI (na pjesme unutar miksa)
    for key, col in [
        ("origin", "origin"),
        ("vocal", "vocal"),
        ("tempo", "tempo"),
        ("genre", "genre"),
        ("regija", "region"),
    ]:
        if filters[key]:
            query += f"""
                AND EXISTS (
                    SELECT 1
                    FROM songs s
                    WHERE s.mix_id = m.id
                      AND s.status = 'repertoar'
                      AND s.{col} = ?
                )
            """
            params.append(filters[key])

    if filters["instrumental"] == "1":
        query += """
            AND EXISTS (
                SELECT 1
                FROM songs s
                WHERE s.mix_id = m.id
                  AND s.status = 'repertoar'
                  AND s.is_instrumental = 1
            )
        """

    if filters["q"]:
        query += """
            AND (
                m.name LIKE ?
                OR EXISTS (
                    SELECT 1
                    FROM songs s
                    WHERE s.mix_id = m.id
                      AND (
                          s.title LIKE ?
                          OR s.artist LIKE ?
                      )
                )
            )
        """
        params += [f"%{filters['q']}%"] * 3

    query += " ORDER BY LOWER(m.name)"

    mixes = db.execute(query, params).fetchall()

    return render_template(
        "mixes.html",
        mixes=mixes,
        filters=filters,
        filters_open=request.args.get("filters") == "1",
        nav=nav_ctx(
            title="Mixevi",
            back_url="/",
            mode="library",
            show_back=True
        )
    )
# ---------- NEW MIX ----------
@app.route("/mix/new", methods=["GET", "POST"])
def mix_new():
    db = get_db()

    if request.method == "POST":
        name = request.form.get("name", "").strip()

        if not name:
            abort(400)

        cur = db.execute(
            """
            INSERT INTO mixes (name, created_at)
            VALUES (?, NOW())
            RETURNING id
            """,
            (name,)
        )
        db.commit()

        mix_id = cur.fetchone()["id"]

        # odmah vodi u edit tog mixa
        return redirect(f"/mix/{mix_id}/edit")

    return render_template(
        "mixes_new.html",
        nav=nav_ctx(
            title="Novi mix",
            back_url="/mixes",
            mode="library",
            show_back=True,
        )
    )
# ---------- EDIT MIX ----------
@app.route("/mix/<int:mix_id>/edit", methods=["GET", "POST"])
def mix_edit(mix_id):
    db = get_db()

    # DOHVAT MIXA
    mix = db.execute(
        "SELECT * FROM mixes WHERE id = ?",
        (mix_id,)
    ).fetchone()

    if not mix:
        abort(404)

    # -----------------------------
    # UPDATE NAZIVA MIXA
    # -----------------------------
    if request.method == "POST":
        name = request.form.get("name", "").strip()
        if not name:
            abort(400)

        db.execute(
            "UPDATE mixes SET name = ? WHERE id = ?",
            (name, mix_id)
        )
        db.commit()

        # ⬅️ nakon save-a ide nazad na listu mikseva
        return redirect("/mixes")

    # -----------------------------
    # PJESME U OVOM MIXU
    # (redoslijed je KLJUČAN)
    # -----------------------------
    mix_songs = db.execute(
        """
        SELECT
            id,
            title,
            artist,
            key,
            mix_order
        FROM songs
        WHERE mix_id = ?
        ORDER BY mix_order ASC
        """,
        (mix_id,)
    ).fetchall()

    return render_template(
        "mixes_edit.html",
        mix=mix,
        mix_songs=mix_songs,
        nav=nav_ctx(
            title="Uredi mix",
            back_url="/mixes",
            mode="library",
            show_back=True
        )
    )


# ---------- REORDER SONGS IN MIX ----------
@app.route("/mix/<int:mix_id>/reorder", methods=["POST"])
def mix_reorder(mix_id):
    db = get_db()

    data = request.get_json()
    order = data.get("order")

    if not order:
        abort(400)

    # 🔑 sekvencijalno spremanje novog redoslijeda
    for index, song_id in enumerate(order, start=1):
        db.execute(
            """
            UPDATE songs
            SET mix_order = ?
            WHERE id = ? AND mix_id = ?
            """,
            (index, song_id, mix_id)
        )

    db.commit()
    return ("", 204)


# ---------- ADD SONGS TO MIX ----------
@app.route("/mix/<int:mix_id>/add", methods=["GET", "POST"])
def mix_add(mix_id):
    db = get_db()

    mix = db.execute(
        "SELECT * FROM mixes WHERE id = ?",
        (mix_id,)
    ).fetchone()

    if not mix:
        abort(404)

    # FILTERI (isti model kao repertoar / setlist add)
    filters = {
        "origin": request.args.get("origin"),
        "vocal": request.args.get("vocal"),
        "tempo": request.args.get("tempo"),
        "genre": request.args.get("genre"),
        "regija": request.args.get("regija"),
        "instrumental": request.args.get("instrumental"),
        "q": request.args.get("q")
    }

    query = """
        SELECT id, title, artist, key
        FROM songs
        WHERE status = 'repertoar'
          AND (mix_id IS NULL OR mix_id != ?)
    """

    params = [mix_id]

    # FILTERI
    for key, col in [
        ("origin", "origin"),
        ("vocal", "vocal"),
        ("tempo", "tempo"),
        ("genre", "genre"),
        ("regija", "region"),
    ]:
        if filters[key]:
            query += f" AND {col} = ?"
            params.append(filters[key])

    if filters["instrumental"] == "1":
        query += " AND is_instrumental = 1"

    if filters["q"]:
        query += """
            AND (
                title LIKE ?
                OR artist LIKE ?
            )
        """
        params += [f"%{filters['q']}%"] * 2

    query += " ORDER BY LOWER(title)"

    songs = db.execute(query, params).fetchall()

    return render_template(
        "mixes_add.html",
        mix=mix,
        songs=songs,
        filters=filters,
        filters_open=request.args.get("filters") == "1",
        nav=nav_ctx(
            title=f"Dodaj u {mix['name']}",
            back_url=f"/mix/{mix_id}/edit",
            mode="library",
            show_back=True
        )
    )
# ---------- ADD SONG TO MIX ----------
@app.route("/mix/<int:mix_id>/add_song", methods=["POST"])
def mix_add_song(mix_id):
    db = get_db()

    song_id = request.form.get("song_id")
    if not song_id:
        abort(400)

    # zadnji redni broj u mixu
    last_pos = db.execute(
        "SELECT COALESCE(MAX(mix_order), 0) FROM songs WHERE mix_id = ?",
        (mix_id,)
    ).fetchone()[0]

    db.execute(
        """
        UPDATE songs
        SET mix_id = ?, mix_order = ?
        WHERE id = ?
        """,
        (mix_id, last_pos + 1, song_id)
    )
    db.commit()

    return redirect(f"/mix/{mix_id}/add")
# ---------- REMOVE SONG FROM MIX ----------
@app.route("/mix/<int:mix_id>/remove/<int:song_id>", methods=["POST"])
def mix_remove_song(mix_id, song_id):
    db = get_db()

    db.execute(
        "UPDATE songs SET mix_id = NULL WHERE id = ? AND mix_id = ?",
        (song_id, mix_id)
    )
    db.commit()

    return redirect(f"/mix/{mix_id}/edit")

# ---------- DELETE MIX ----------
@app.route("/mix/<int:mix_id>/delete", methods=["POST"])
def mix_delete(mix_id):
    db = get_db()
    require_admin()

    # prvo makni pjesme iz mixa
    db.execute(
        "UPDATE songs SET mix_id = NULL WHERE mix_id = ?",
        (mix_id,)
    )

    # obriši mix
    db.execute(
        "DELETE FROM mixes WHERE id = ?",
        (mix_id,)
    )

    db.commit()
    return redirect("/mixes")
# ---------- MIX DETAIL ----------
@app.route("/mix/<int:mix_id>")
def mix_detail(mix_id):
    db = get_db()

    mix = db.execute(
        "SELECT * FROM mixes WHERE id = ?", (mix_id,)
    ).fetchone()

    if not mix:
        abort(404)

    songs = db.execute("""
        SELECT *
        FROM songs
        WHERE mix_id = ? AND status = 'repertoar'
        ORDER BY mix_order, title
    """, (mix_id,)).fetchall()

    from_param = request.args.get("from")
    set_id = request.args.get("set")

    # -------------------------------------------------
    # BACK LOGIKA (OSTAJE TVOJA)
    # -------------------------------------------------

    if from_param == "setlist" and set_id:
        back_url = f"/setlist/{set_id}"

    elif from_param and from_param.startswith("/probe/"):
        back_url = from_param

    elif from_param:
        back_url = from_param

    else:
        back_url = "/mixes"

    # -------------------------------------------------
    # 🔥 SWIPE SUPPORT (DODANO)
    # -------------------------------------------------

    set_items = []
    current_index = None

    if from_param == "setlist" and set_id:

        items = db.execute("""
            SELECT item_type, item_id
            FROM setlist_items
            WHERE setlist_id=?
            ORDER BY position
        """, (set_id,)).fetchall()

        for i, item in enumerate(items):
            set_items.append({
                "type": item["item_type"],
                "id": item["item_id"]
            })

            if item["item_type"] == "mix" and item["item_id"] == mix_id:
                current_index = i

    return render_template(
    "mix.html",
    mix=mix,
    songs=songs,
    set_items=set_items,
    current_index=current_index,
    nav=nav_ctx(
        title=mix["name"],
        back_url=back_url,
        mode="library",
        show_back=True,
        show_settings=False
    )
)


# ---------- PROBE LIST ----------
@app.route("/probe")
def probe_list():
    db = get_db()

    rehearsals = db.execute("""
        SELECT r.*, COUNT(s.id) AS song_count
        FROM rehearsals r
        LEFT JOIN rehearsal_songs rs ON rs.rehearsal_id = r.id
        LEFT JOIN songs s ON s.id = rs.song_id
        WHERE r.status = 'planned'
        GROUP BY r.id
        ORDER BY r.date DESC
    """).fetchall()

    return render_template(
    "probe.html",
    rehearsals=rehearsals,
    nav=nav_ctx(
        title="Probe",
        back_url="/",
        mode="rehearsal",
        show_back=True
    )
)


# ---------- NOVA PROBA ----------
@app.route("/probe/new", methods=["GET", "POST"])
def probe_new():
    if request.method == "POST":
        name = request.form.get("name")
        date = request.form.get("date")
        note = request.form.get("note")

        if not name or not date:
            abort(400)

        db = get_db()
        cur = db.execute("""
            INSERT INTO rehearsals (name, date, note, status)
            VALUES (?, ?, ?, 'planned')
            RETURNING id
        """, (name, date, note))
        db.commit()

        return redirect(f"/probe/{cur.fetchone()['id']}")

    return render_template(
    "probe_new.html",
    nav=nav_ctx(
        title="Nova proba",
        back_url="/probe",
        mode="rehearsal",
        show_back=True
    )
)

# ---------- EDIT PROBA ----------
@app.route("/probe/<int:rehearsal_id>/edit", methods=["GET", "POST"])
def probe_edit(rehearsal_id):
    db = get_db()

    rehearsal = db.execute(
        "SELECT * FROM rehearsals WHERE id=?",
        (rehearsal_id,)
    ).fetchone()

    if not rehearsal:
        abort(404)

    if request.method == "POST":

        db.execute("""
            UPDATE rehearsals
            SET name=?,
                date=?,
                note=?
            WHERE id=?
        """, (
            request.form.get("name"),
            request.form.get("date"),
            request.form.get("note"),
            rehearsal_id
        ))

        db.commit()
        return redirect("/probe")

    return render_template(
    "probe_edit.html",
    rehearsal=rehearsal,
    nav=nav_ctx(
        title="Uredi probu",
        back_url="/probe",
        mode="rehearsal",
        show_back=True
    )
)
# ---------- DELETE PROBA ----------
@app.route("/probe/<int:rehearsal_id>/delete", methods=["POST"])
def delete_probe(rehearsal_id):
    db = get_db()

    # prvo obriši povezane pjesme
    db.execute(
        "DELETE FROM rehearsal_songs WHERE rehearsal_id=?",
        (rehearsal_id,)
    )

    # onda obriši probu
    db.execute(
        "DELETE FROM rehearsals WHERE id=?",
        (rehearsal_id,)
    )

    db.commit()

    return redirect("/probe")

# ---------- PROBE DETAIL ----------
@app.route("/probe/<int:rehearsal_id>")
def probe_detail(rehearsal_id):
    db = get_db()

    rehearsal = db.execute(
        "SELECT * FROM rehearsals WHERE id = ?", (rehearsal_id,)
    ).fetchone()
    if not rehearsal:
        abort(404)

    songs = db.execute("""
        SELECT s.*
        FROM songs s
        JOIN rehearsal_songs rs ON rs.song_id = s.id
        WHERE rs.rehearsal_id = ?
        ORDER BY s.title
    """, (rehearsal_id,)).fetchall()

    mixes = db.execute("SELECT name FROM mixes ORDER BY name").fetchall()
    artists = db.execute("SELECT DISTINCT artist FROM songs ORDER BY artist").fetchall()

    adding = request.args.get("add") == "1"

    return render_template(
        "probe_detail.html",
        rehearsal=rehearsal,
        songs=songs,
        mixes=mixes,
        artists=artists,
        adding=adding,   # 👈 KLJUČNO
        nav=nav_ctx(
            title=rehearsal["name"],
            back_url="/probe",
            mode="rehearsal",
            show_back=True
        )
)


# ---------- ADD SONG TO PROBE ----------
@app.route("/probe/<int:rehearsal_id>/add", methods=["POST"])
def add_song_to_probe(rehearsal_id):
    db = get_db()

    title = request.form.get("title")
    artist = request.form.get("artist")

    if not title or not artist:
        abort(400)

    planned_mix = request.form.get("planned_mix")
    planned_mix_new = request.form.get("planned_mix_new")
    mix_order = request.form.get("mix_order")

    final_planned_mix = planned_mix_new or planned_mix

    if final_planned_mix and not mix_order:
        abort(400)

    song = db.execute("""
        SELECT id FROM songs
        WHERE LOWER(title)=LOWER(?) AND LOWER(artist)=LOWER(?)
    """, (title, artist)).fetchone()

    if not song:
        cur = db.execute("""
            INSERT INTO songs (
                title, artist, key, tempo, genre, region, vocal,
                origin, theme, lyrics, is_instrumental,
                planned_mix, mix_order, status
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'probe')
            RETURNING id
        """, (
            title,
            artist,
            request.form.get("key"),
            request.form.get("tempo"),
            request.form.get("genre"),
            request.form.get("region"),
            request.form.get("vocal"),
            request.form.get("origin"),
            request.form.get("theme"),
            request.form.get("lyrics"),
            1 if request.form.get("is_instrumental") else 0,
            final_planned_mix,
            int(mix_order) if mix_order else None
        ))
        song_id = cur.fetchone()["id"]
    else:
        song_id = song["id"]

    db.execute("""
        INSERT INTO rehearsal_songs (rehearsal_id, song_id)
        VALUES (?, ?) ON CONFLICT DO NOTHING
    """, (rehearsal_id, song_id))

    db.commit()
    return redirect(f"/probe/{rehearsal_id}")


# ---------- PUSH SONG ----------
@app.route("/probe/push/<int:song_id>", methods=["POST"])
def push_song(song_id):
    db = get_db()

    song = db.execute(
        "SELECT * FROM songs WHERE id = ?", (song_id,)
    ).fetchone()
    if not song:
        abort(404)

    mix_id = None
    if song["planned_mix"]:
        mix = db.execute(
            "SELECT id FROM mixes WHERE name = ?", (song["planned_mix"],)
        ).fetchone()

        if not mix:
            cur = db.execute(
                "INSERT INTO mixes (name) VALUES (?) RETURNING id",
                (song["planned_mix"],)
            )
            mix_id = cur.fetchone()["id"]
        else:
            mix_id = mix["id"]

    db.execute("""
        UPDATE songs
        SET status='repertoar',
            mix_id=?
        WHERE id=?
    """, (mix_id, song_id))

    db.commit()
    return redirect(request.referrer or "/probe")


# ---------- REMOVE SONG FROM PROBE ----------
@app.route("/probe/<int:rehearsal_id>/remove/<int:song_id>", methods=["POST"])
def remove_song_from_probe(rehearsal_id, song_id):
    db = get_db()

    db.execute(
        "DELETE FROM rehearsal_songs WHERE rehearsal_id=? AND song_id=?",
        (rehearsal_id, song_id)
    )

    db.commit()
    return redirect(f"/probe/{rehearsal_id}")


# ---------- ADD SONG DIRECTLY TO REPERTOAR ----------
@app.route("/repertoar/add", methods=["POST"])
def add_song_to_repertoar():
    db = get_db()

    db.execute("""
        INSERT INTO songs (
            title, artist, key, tempo, genre, region, vocal,
            origin, theme, lyrics, is_instrumental, status
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'repertoar')
    """, (
        request.form.get("title"),
        request.form.get("artist"),
        request.form.get("key"),
        request.form.get("tempo"),
        request.form.get("genre"),
        request.form.get("region"),
        request.form.get("vocal"),
        request.form.get("origin"),
        request.form.get("theme"),
        request.form.get("lyrics"),
        1 if request.form.get("is_instrumental") else 0
    ))

    db.commit()
    return redirect("/repertoar")

# ---------- SET LISTE ----------
@app.route("/setlists")
def setlists():
    db = get_db()

    setlists = db.execute("""
        SELECT s.*, COUNT(i.id) AS item_count
        FROM setlists s
        LEFT JOIN setlist_items i ON i.setlist_id = s.id
        GROUP BY s.id
        ORDER BY s.date DESC
    """).fetchall()

    return render_template(
    "setlists.html",
    setlists=setlists,
    nav=nav_ctx(
        title="Set liste",
        back_url="/",
        mode="setlist",
        show_back=True
    )
)

# ---------- NOVA SET LISTA ----------
@app.route("/setlist/new", methods=["GET", "POST"])
def setlist_new():

    if request.method == "POST":

        name = request.form.get("name")
        date = request.form.get("date")
        note = request.form.get("note")

        if not name or not date:
            abort(400)

        db = get_db()

        cur = db.execute("""
            INSERT INTO setlists (name, date, note)
            VALUES (?, ?, ?)
            RETURNING id
        """, (name, date, note))

        db.commit()

        return redirect(f"/setlist/{cur.fetchone()['id']}")

    return render_template(
    "setlist_new.html",
    nav=nav_ctx(
        title="Nova set lista",
        back_url="/setlists",
        mode="setlist",
        show_back=True
    )
)

# ---------- SETLIST DETAIL ----------
@app.route("/setlist/<int:setlist_id>")
def setlist_detail(setlist_id):
    db = get_db()

    setlist = db.execute(
        "SELECT * FROM setlists WHERE id=?",
        (setlist_id,)
    ).fetchone()

    if not setlist:
        abort(404)

    items = db.execute("""
       SELECT 
        i.*,
        s.title AS song_title,
        s.artist AS song_artist,
        s.key AS key,
        m.name AS mix_name,
        STRING_AGG(ms.title, ', ') AS song_titles,
        MIN(ms.key) AS mix_key
    FROM setlist_items i
    LEFT JOIN songs s
        ON i.item_type='song' AND i.item_id = s.id
    LEFT JOIN mixes m
        ON i.item_type='mix' AND i.item_id = m.id
    LEFT JOIN songs ms
        ON ms.mix_id = m.id AND ms.status='repertoar'
    WHERE i.setlist_id = ?
    GROUP BY 
        i.id,
        s.title,
        s.artist,
        s.key,
        m.name
    ORDER BY i.position
    """, (setlist_id,)).fetchall()

    return render_template(
    "setlist_detail.html",
    setlist=setlist,
    items=items,
    nav=nav_ctx(
        title=setlist["name"],
        back_url="/setlists",
        mode="setlist",
        show_back=True
    )
)
    # ---------- SETLIST ITEM VIEW ----------
@app.route("/setlist/<int:setlist_id>/item/<int:item_id>")
def setlist_item_view(setlist_id, item_id):

    db = get_db()

    # Dohvati sve iteme u setu
    items = db.execute("""
        SELECT id
        FROM setlist_items
        WHERE setlist_id=?
        ORDER BY position
    """, (setlist_id,)).fetchall()

    item_ids = [row["id"] for row in items]

    if item_id not in item_ids:
        abort(404)

    index = item_ids.index(item_id)

    prev_id = item_ids[index - 1] if index > 0 else None
    next_id = item_ids[index + 1] if index < len(item_ids) - 1 else None

    # Dohvati konkretan item
    item = db.execute("""
        SELECT *
        FROM setlist_items
        WHERE id=? AND setlist_id=?
    """, (item_id, setlist_id)).fetchone()

    if not item:
        abort(404)

    # =========================
    # AKO JE SONG
    # =========================
    if item["item_type"] == "song":

        song = db.execute("""
            SELECT *
            FROM songs
            WHERE id=?
        """, (item["item_id"],)).fetchone()

        return render_template(
            "song.html",
            song=song,
            setlist_mode=True,
            setlist_id=setlist_id,
            prev_id=prev_id,
            next_id=next_id,
            nav=nav_ctx(
                title=song["title"],
                back_url=f"/setlist/{setlist_id}",
                mode="setlist",
                show_back=True
            )
        )

    # =========================
    # AKO JE MIX
    # =========================
    else:

        mix = db.execute(
            "SELECT * FROM mixes WHERE id=?",
            (item["item_id"],)
        ).fetchone()

        songs = db.execute("""
            SELECT *
            FROM songs
            WHERE mix_id=? AND status='repertoar'
            ORDER BY mix_order, title
        """, (mix["id"],)).fetchall()

        return render_template(
            "mix.html",
            mix=mix,
            songs=songs,
            setlist_mode=True,
            setlist_id=setlist_id,
            prev_id=prev_id,
            next_id=next_id,
            nav=nav_ctx(
                title=mix["name"],
                back_url=f"/setlist/{setlist_id}",
                mode="setlist",
                show_back=True
            )
        )


# ---------- EDIT SET LIST ----------
@app.route("/setlist/<int:setlist_id>/edit", methods=["GET", "POST"])
def setlist_edit(setlist_id):
    db = get_db()

    setlist = db.execute(
        "SELECT * FROM setlists WHERE id=?",
        (setlist_id,)
    ).fetchone()

    if not setlist:
        abort(404)

    if request.method == "POST":
        db.execute("""
            UPDATE setlists
            SET name=?,
                date=?,
                note=?
            WHERE id=?
        """, (
            request.form.get("name"),
            request.form.get("date"),
            request.form.get("note"),
            setlist_id
        ))

        db.commit()
        return redirect("/setlists")

    return render_template(
    "setlist_edit.html",
    setlist=setlist,
    nav=nav_ctx(
        title="Uredi set listu",
        back_url="/setlists",
        mode="setlist",
        show_back=True
    )
)

# ---------- DELETE SET LIST ----------
@app.route("/setlist/<int:setlist_id>/delete", methods=["POST"])
def setlist_delete(setlist_id):
    db = get_db()
    require_admin()

    # prvo obriši sve iteme
    db.execute(
        "DELETE FROM setlist_items WHERE setlist_id=?",
        (setlist_id,)
    )

    # onda obriši setlistu
    db.execute(
        "DELETE FROM setlists WHERE id=?",
        (setlist_id,)
    )

    db.commit()
    return redirect("/setlists")

# ---------- ADD ITEM TO SETLIST ----------
@app.route("/setlist/<int:setlist_id>/add", methods=["GET"])
def setlist_add(setlist_id):
    db = get_db()

    setlist = db.execute(
        "SELECT * FROM setlists WHERE id=?",
        (setlist_id,)
    ).fetchone()

    if not setlist:
        abort(404)

    filters = {
        "origin": request.args.get("origin"),
        "vocal": request.args.get("vocal"),
        "tempo": request.args.get("tempo"),
        "genre": request.args.get("genre"),
        "regija": request.args.get("regija"),
        "mix": request.args.get("mix"),
        "instrumental": request.args.get("instrumental"),
        "q": request.args.get("q")
    }

    # =====================================================
    # SONG QUERY
    # =====================================================

    song_query = """
        SELECT id, title, artist, key
        FROM songs
        WHERE status='repertoar'
    """
    song_params = []

    for key, col in [
        ("origin", "origin"),
        ("vocal", "vocal"),
        ("tempo", "tempo"),
        ("genre", "genre"),
        ("regija", "region"),
    ]:
        if filters[key]:
            song_query += f" AND {col}=?"
            song_params.append(filters[key])

    if filters["instrumental"] == "1":
        song_query += " AND is_instrumental=1"

    if filters["mix"] == "1":
        song_query += " AND mix_id IS NOT NULL"

    if filters["q"]:
        song_query += " AND (title LIKE ? OR artist LIKE ?)"
        song_params += [f"%{filters['q']}%"] * 2

    song_query += " ORDER BY LOWER(title)"
    songs = db.execute(song_query, song_params).fetchall()

    # =====================================================
    # MIX QUERY
    # =====================================================

    mix_query = """
        SELECT 
            m.id,
            m.name,
            STRING_AGG(s.title, ', ') AS song_titles,
            MIN(s.key) AS mix_key
        FROM mixes m
        JOIN songs s ON s.mix_id = m.id
        WHERE s.status='repertoar'
    """

    mix_params = []

    # 🔥 OVDJE JE KLJUČ — FILTRI SE PRIMJENJUJU NA SONGS

    for key, col in [
        ("origin", "s.origin"),
        ("vocal", "s.vocal"),
        ("tempo", "s.tempo"),
        ("genre", "s.genre"),
        ("regija", "s.region"),
    ]:
        if filters[key]:
            mix_query += f" AND {col}=?"
            mix_params.append(filters[key])

    if filters["instrumental"] == "1":
        mix_query += " AND s.is_instrumental=1"

    if filters["q"]:
        mix_query += """
            AND (
                m.name LIKE ?
                OR s.title LIKE ?
                OR s.artist LIKE ?
            )
        """
        mix_params += [f"%{filters['q']}%"] * 3

    mix_query += """
        GROUP BY m.id
        ORDER BY LOWER(m.name)
    """

    mixes = db.execute(mix_query, mix_params).fetchall()

    # =====================================================
    # AKO JE MIX FILTER UKLJUČEN → PRIKAZUJ SAMO MIXEVE
    # =====================================================

    if filters["mix"] == "1":
        songs = []

    # =====================================================

    return render_template(
    "setlist_add.html",
    setlist=setlist,
    songs=songs,
    mixes=mixes,
    filters=filters,
    filters_open=request.args.get("filters") == "1",
    nav=nav_ctx(
        title="Dodaj u set",
        back_url=f"/setlist/{setlist_id}",
        mode="setlist",
        show_back=True
    )
)


# ---------- REMOVE ITEM FROM SETLIST ----------
@app.route("/setlist/<int:setlist_id>/remove/<int:item_id>", methods=["POST"])
def setlist_remove_item(setlist_id, item_id):
    db = get_db()

    db.execute("""
        DELETE FROM setlist_items
        WHERE id=? AND setlist_id=?
    """, (item_id, setlist_id))

    db.commit()

    return redirect(f"/setlist/{setlist_id}")

# ---------- INSERT ITEM ----------
@app.route("/setlist/<int:setlist_id>/add_item", methods=["POST"])
def setlist_add_item(setlist_id):
    db = get_db()

    item_type = request.form.get("item_type")
    item_id = request.form.get("item_id")

    # sljedeća pozicija
    last = db.execute("""
        SELECT MAX(position) FROM setlist_items
        WHERE setlist_id=?
    """, (setlist_id,)).fetchone()[0]

    next_position = (last or 0) + 1

    db.execute("""
        INSERT INTO setlist_items (setlist_id, item_type, item_id, position)
        VALUES (?, ?, ?, ?)
    """, (
        setlist_id,
        item_type,
        item_id,
        next_position
    ))

    db.commit()
    return redirect(f"/setlist/{setlist_id}")
 # ---------- REORDER SETLIST ----------
@app.route("/setlist/<int:setlist_id>/reorder", methods=["POST"])
def setlist_reorder(setlist_id):
    db = get_db()

    order = request.json  # <-- OVDJE JE BITNA PROMJENA

    if not order:
        abort(400)

    for item in order:
        db.execute("""
            UPDATE setlist_items
            SET position=?
            WHERE id=? AND setlist_id=?
        """, (
            item["position"],
            item["id"],
            setlist_id
        ))

    db.commit()
    return {"status": "ok"}
 

# ---------- SETTINGS ----------
@app.route("/settings")
def settings_page():

    back_url = request.referrer or "/"

    return render_template(
        "settings.html",
        nav=nav_ctx(
            title="Postavke",
            back_url=back_url,
            mode="library",
            show_back=True
        )
    )

# ---------- INFO SONG STATS ----------
@app.route("/info_song")
def info_song():
    db = get_db()

    stats = db.execute(
        "SELECT * FROM v_home_stats"
    ).fetchone()

    if not stats:
        abort(404)

    return stats

# ---------- CUSTOM 403 ----------
@app.errorhandler(403)
def forbidden(e):
    return render_template(
        "403.html",
        nav=nav_ctx(
            title="Nedozvoljena akcija",
            back_url="/",
            mode="library",
            show_back=True
        )
    ), 403
# ---------- RUN ----------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
