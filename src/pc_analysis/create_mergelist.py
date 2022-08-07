with open("mergelist.txt", "w") as f:
    for i in range(1, 23):
        f.write(f"chr{i}.pass_only_filtered\n")

