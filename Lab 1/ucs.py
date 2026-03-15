from heapq import heappop, heappush, heapify
import json
import time

with open('G.json', 'r') as file:
    G_node = json.load(file)

with open('Coord.json', 'r') as file:
    coords = json.load(file)

with open('Dist.json', 'r') as file:
    distpair = json.load(file)

with open('Cost.json', 'r') as file:
    cost = json.load(file)

def ucs(maxenergy, start, end):
    totaldist = {start: 0}
    energy = {start: 0}
    parent = {}
    nextqueue = []
    heappush(nextqueue, (0, start))

    nodes_expanded = 0

    while len(nextqueue) != 0:
        accdist, cur = heappop(nextqueue)

        nodes_expanded += 1

        if cur == end:
            path = []
            node = end
            path.append(node)
            while node in parent:
                node = parent[node]
                path.append(node)
            path.reverse()
            return path, totaldist[end], energy[end], nodes_expanded

        for node in G_node[cur]:
            pair = cur + "," + node
            if cost[pair] + energy[cur] > maxenergy:
                continue
            elif node not in totaldist or distpair[pair] + accdist < totaldist[node]:
                totaldist[node] = distpair[pair] + accdist
                energy[node] = cost[pair] + energy[cur]
                parent[node] = cur
                heappush(nextqueue, (totaldist[node], node)) 
    return None, -1, -1, nodes_expanded
        


energy = 287932
S, T = '1', '50'
runs = 1000
runtimes = []
path = None
nodes_expanded = None
min_dist = None
total_energy = None

for i in range(runs):
    start_time = time.perf_counter()
    p, d, e, n = ucs(energy, S, T)
    end_time = time.perf_counter()

    runtimes.append(end_time - start_time)

    if path is None:
        path = p
        min_dist = d
        total_energy = e
        nodes_expanded = n

avg_runtime = sum(runtimes) / runs

if path is None:
    print("No path available")
else:
    print("Shortest path: ", end="")
    print("->".join(path))
    print(f"Shortest distance: {min_dist}")
    print(f"Total energy cost: {total_energy}")
    print("Nodes expanded:", nodes_expanded)
    print("UCS avg runtime:", avg_runtime)