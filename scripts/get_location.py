def main():
    updates = []

    while True:
        name = input("Enter building name (or 'q' to quit): ").strip()
        if name.lower() == 'q':
            break

        coords = input("Enter lat,lng: ").strip()
        try:
            lat_str, lng_str = coords.split(',')
            lat = float(lat_str.strip())
            lng = float(lng_str.strip())
        except Exception as e:
            print("❌ Invalid coordinate format. Try again.")
            continue

        updates.append(f"UPDATE buildings SET lat = {lat}, lng = {lng} WHERE name = '{name}';")

    print("\n-- SQL Output:")
    for stmt in updates:
        print(stmt)

if __name__ == "__main__":
    main()
