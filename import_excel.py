# -*- coding: utf-8 -*-

import sqlite3
import pandas as pd

DB_PATH = "repertoire.db"
EXCEL_PATH = "bandhelper_final_ui_ready_v5.xlsx"

# ----------------- DB -----------------
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# ----------------- LOAD EXCEL -----------------
df = pd.read_excel(EXCEL_PATH)
df = df.fillna("")

# ----------------- HELPERS -----------------
def get_or_create_mix(name):
    cur.execute("SELECT id FROM mixes WHERE name = ?", (name,))
    row = cur.fetchone()
    if row:
        return row["id"]

    cur.execute("INSERT INTO mixes (name) VALUES (?)", (name,))
    return cur.lastrowid


def song_exists(title, artist):
    cur.execute(
        "SELECT id FROM songs WHERE title = ? AND artist = ?",
        (title.strip(), artist.strip())
    )
    return cur.fetchone() is not None


# ----------------- IMPORT -----------------
mix_orders = {}  # mix_id -> current order

inserted = 0
skipped = 0

for idx, row in df.iterrows():
    title = row.get("title", "").strip()
    artist = row.get("artist", "").strip()

    if not title or not artist:
        continue

    # DUPLICATE CHECK
    if song_exists(title, artist):
        print(f"⏭️  Preskačem duplikat: {title} – {artist}")
        skipped += 1
        continue

    # MIX
    mix_id = None
    mix_order = None

    mix_name = row.get("mix_name", "").strip()
    if mix_name:
        mix_id = get_or_create_mix(mix_name)
        mix_orders.setdefault(mix_id, 0)
        mix_orders[mix_id] += 1
        mix_order = mix_orders[mix_id]

    # INSTRUMENTAL
    instrumental = 0
    if str(row.get("instrumental", "")).strip() == "1":
        instrumental = 1

    lyrics = row.get("lyrics", "").strip()
    if lyrics == "":
        lyrics = None

    # INSERT SONG
    cur.execute("""
        INSERT INTO songs (
            title, artist, key, tempo, genre, region, origin,
            lyrics, mix_id, mix_order, is_instrumental
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        title,
        artist,
        row.get("key") or None,
        row.get("tempo") or None,
        row.get("genre") or None,
        row.get("region") or None,
        row.get("origin") or None,
        lyrics,
        mix_id,
        mix_order,
        instrumental
    ))

    inserted += 1
    print(f"✅ Dodano: {title} – {artist}")

conn.commit()
conn.close()

print("\n====================")
print(f"UBACENO: {inserted}")
print(f"PRESKOCENO (duplikati): {skipped}")

