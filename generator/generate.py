import csv
import random
import os
import sys

NUM_ROWS = 50


COLUMNS = ["position", "best_lap_time", "championship_points", "team"]

def generate_row():

    return {
        "position": random.randint(1, 20),
        "best_lap_time": round(random.uniform(80.0, 100.0), 3),
        "championship_points": random.randint(0, 25),
        "team": random.choice([
            "Red Bull",
            "Ferrari",
            "Mercedes",
            "McLaren",
            "Aston Martin"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)
