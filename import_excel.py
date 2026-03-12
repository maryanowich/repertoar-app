# -*- coding: utf-8 -*-

import psycopg2
import pandas as pd

# ----------------- CONFIG -----------------
DB_CONFIG = {
    "host": "localhost",
    "dbname": "repertoar",
    "user": "markomarjanovic",
    "password": ""
}

EXCEL_PATH = "bandhelper_final_ui_ready_v6.xlsx"

# ----------------- DB -----------------
conn = psycopg2.connect(**DB_CONFIG)
cur = conn.cursor()

# ----------------- LOAD EXCEL -----------------
df = pd.read_excel(EXCEL_PATH)
df = df.where(pd.notnull(df), None)

# ----------------- HELPERS -----------------

def normalize_text(text):
    # treat pandas NaN / empty as None
    if text is None:
        return None
    try:
        if pd.isna(text):
            return None
    except Exception:
        pass

    value = str(text).strip()

    # protect against "nan" strings coming from pandas
    if value == "" or value.lower() == "nan":
        return None

    return value

def normalize_compare(text):
    if text is None:
        return None
    return str(text).strip().lower()


def get_or_create_mix(name):
    cur.execute("SELECT id FROM mixes WHERE name = %s", (name,))
    row = cur.fetchone()

    if row:
        return row[0]

    cur.execute("INSERT INTO mixes (name) VALUES (%s) RETURNING id", (name,))
    return cur.fetchone()[0]


def song_exists(title, artist):
    cur.execute(
        """
        SELECT id
        FROM songs
        WHERE LOWER(TRIM(title)) = %s
        AND LOWER(TRIM(artist)) = %s
        """,
        (title, artist)
    )
    return cur.fetchone() is not None


# ----------------- IMPORT -----------------

mix_orders = {}
inserted = 0
skipped = 0

for idx, row in df.iterrows():

    title = normalize_text(row.get("title"))
    artist = normalize_text(row.get("artist"))
    # normalized values for safer duplicate detection (case / whitespace differences)
    title_compare = normalize_compare(title)
    artist_compare = normalize_compare(artist)

    if not title or not artist:
        continue

    # DUPLICATE CHECK
    if song_exists(title_compare, artist_compare):
        print(f"⏭️ Preskačem duplikat: {title} – {artist}")
        skipped += 1
        continue

    key = normalize_text(row.get("key"))
    tempo = normalize_text(row.get("tempo"))
    origin = normalize_text(row.get("origin"))
    genre = normalize_text(row.get("genre"))
    region = normalize_text(row.get("region"))
    vocal = normalize_text(row.get("vocal"))
    lyrics = normalize_text(row.get("lyrics"))
    theme = normalize_text(row.get("theme"))
    score_pdf = normalize_text(row.get("score_pdf"))

    # INSTRUMENTAL (ensure safe integer for PostgreSQL)
    instrumental = row.get("is_instrumental")
    if instrumental in [None, "", "None"]:
        instrumental = 0
    else:
        try:
            instrumental = int(instrumental)
        except Exception:
            instrumental = 0

    # STATUS DEFAULT (protect against Excel NaN)
    raw_status = row.get("status")

    if raw_status is None:
        status = "repertoar"
    else:
        status = str(raw_status).strip()

        # pandas often returns NaN which becomes string "nan"
        if status == "" or status.lower() == "nan":
            status = "repertoar"

    # MIX
    mix_id = None
    mix_order = None

    mix_name = normalize_text(row.get("mix_name"))

    # prevent accidental "nan" mix creation
    if mix_name is None:
        mix_id = None
        mix_order = None

    # ensure safe numeric counters
    if mix_name is not None:
        mix_id = get_or_create_mix(mix_name)
        mix_orders.setdefault(mix_id, 0)
        mix_orders[mix_id] += 1
        mix_order = mix_orders[mix_id]

    # INSERT SONG
    cur.execute(
        """
        INSERT INTO songs (
            title,
            artist,
            key,
            tempo,
            origin,
            genre,
            region,
            vocal,
            lyrics,
            theme,
            is_instrumental,
            score_pdf,
            status,
            mix_id,
            mix_order
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """,
        (
            title,
            artist,
            key,
            tempo,
            origin,
            genre,
            region,
            vocal,
            lyrics,
            theme,
            instrumental,
            score_pdf,
            status,
            mix_id,
            mix_order
        )
    )

    inserted += 1
    print(f"✅ Dodano: {title} – {artist}")

conn.commit()
cur.close()
conn.close()

print("\n====================")
print(f"UBACENO: {inserted}")
print(f"PRESKOCENO (duplikati): {skipped}")
