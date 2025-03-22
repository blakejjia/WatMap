import json


def add_offset_to_vector(vector, building):
    offset = [-33,-32];
    left = vector[0] + offset[0]
    top = vector[1] + offset[1]
    name = building
    return json.dumps({"name": name, "position": {"left": left, "top": top}})

if __name__ == "__main__":
        
    buildings = [];

    while True:
        input_building = input("Enter the building name (or 'q' to quit): ")
        if not input_building:
            print("Building name cannot be empty. Please try again.")
            continue
        if input_building.lower() == 'q':
            break

        try:
            input_x = int(input("Enter the x coordinate: "))
        except ValueError:
            print("Invalid input for x coordinate. Please enter a number.")
            continue

        try:
            input_y = int(input("Enter the y coordinate: "))
        except ValueError:
            print("Invalid input for y coordinate. Please enter a number.")
            continue
        input_vector = [input_x, input_y]
        buildings.append(json.loads(add_offset_to_vector(input_vector, input_building)))

    print(json.dumps(buildings, indent=4))