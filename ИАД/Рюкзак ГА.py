import functools
import itertools
import multiprocessing
from random import random, seed, choice
from time import time, perf_counter
from math import floor
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from concurrent.futures import ProcessPoolExecutor, as_completed
import queue

seed(time())  # инициализация ГПСЧ

## ОПТ 375

# ОПТ 6380
SAMPLES = [
    {'c': 1, 'w': 100, 'm': 1},
    {'c': 2, 'w': 100, 'm': 1},
    {'c': 3, 'w': 100, 'm': 2},
    {'c': 4, 'w': 100, 'm': 1},
    {'c': 5, 'w': 100, 'm': 1},
    {'c': 6, 'w': 100, 'm': 1},
    {'c': 7, 'w': 100, 'm': 1},
    {'c': 8, 'w': 100, 'm': 1},
    {'c': 9, 'w': 100, 'm': 1},
    {'c': 10, 'w': 100, 'm': 1},
    {'c': 11, 'w': 100, 'm': 1},
    {'c': 12, 'w': 100, 'm': 1},
    {'c': 13, 'w': 100, 'm': 1},
    {'c': 14, 'w': 100, 'm': 1},
    {'c': 15, 'w': 100, 'm': 1},
    {'c': 16, 'w': 100, 'm': 1},
    {'c': 17, 'w': 100, 'm': 1},
    {'c': 18, 'w': 100, 'm': 1},
    {'c': 19, 'w': 100, 'm': 1},
    {'c': 20, 'w': 100, 'm': 1},
    {'c': 21, 'w': 100, 'm': 1},
    {'c': 22, 'w': 100, 'm': 1},
    {'c': 23, 'w': 100, 'm': 1},
    {'c': 24, 'w': 100, 'm': 1},
    {'c': 25, 'w': 100, 'm': 1},
    {'c': 26, 'w': 100, 'm': 1},
    {'c': 27, 'w': 100, 'm': 2},
    {'c': 28, 'w': 100, 'm': 1},
    {'c': 29, 'w': 100, 'm': 1},
    {'c': 30, 'w': 100, 'm': 1},
    {'c': 31, 'w': 100, 'm': 1},
    {'c': 32, 'w': 100, 'm': 1},
    {'c': 33, 'w': 100, 'm': 1},
    {'c': 34, 'w': 100, 'm': 1},
    {'c': 35, 'w': 100, 'm': 1},
    {'c': 36, 'w': 100, 'm': 1},
    {'c': 37, 'w': 100, 'm': 1},
    {'c': 38, 'w': 100, 'm': 1},
    {'c': 39, 'w': 100, 'm': 1},
    {'c': 40, 'w': 100, 'm': 1},
    {'c': 41, 'w': 100, 'm': 1},
    {'c': 42, 'w': 100, 'm': 1},
    {'c': 43, 'w': 100, 'm': 1},
    {'c': 44, 'w': 100, 'm': 1},
    {'c': 45, 'w': 100, 'm': 1},
    {'c': 46, 'w': 100, 'm': 1},
    {'c': 47, 'w': 100, 'm': 1},
    {'c': 48, 'w': 100, 'm': 1},
    {'c': 49, 'w': 100, 'm': 1},
    {'c': 50, 'w': 100, 'm': 1},
    {'c': 51, 'w': 100, 'm': 1},
    {'c': 52, 'w': 100, 'm': 1},
    {'c': 53, 'w': 100, 'm': 1},
    {'c': 54, 'w': 100, 'm': 1},
    {'c': 55, 'w': 100, 'm': 1},
    {'c': 56, 'w': 100, 'm': 1},
    {'c': 57, 'w': 100, 'm': 1},
    {'c': 58, 'w': 100, 'm': 1},
    {'c': 59, 'w': 100, 'm': 1},
    {'c': 60, 'w': 100, 'm': 1},
    {'c': 61, 'w': 100, 'm': 1},
    {'c': 62, 'w': 100, 'm': 1},
    {'c': 63, 'w': 100, 'm': 1},
    {'c': 64, 'w': 100, 'm': 1},
    {'c': 65, 'w': 100, 'm': 1},
    {'c': 66, 'w': 100, 'm': 1},
    {'c': 67, 'w': 100, 'm': 1},
    {'c': 68, 'w': 100, 'm': 1},
    {'c': 69, 'w': 100, 'm': 1},
    {'c': 70, 'w': 100, 'm': 1},
    {'c': 71, 'w': 100, 'm': 1},
    {'c': 72, 'w': 100, 'm': 1},
    {'c': 73, 'w': 100, 'm': 1},
    {'c': 74, 'w': 100, 'm': 1},
    {'c': 75, 'w': 100, 'm': 1},
    {'c': 76, 'w': 100, 'm': 1},
    {'c': 77, 'w': 100, 'm': 1},
    {'c': 78, 'w': 100, 'm': 1},
    {'c': 79, 'w': 100, 'm': 1},
    {'c': 80, 'w': 100, 'm': 1},
    {'c': 81, 'w': 100, 'm': 1},
    {'c': 82, 'w': 100, 'm': 1},
    {'c': 83, 'w': 100, 'm': 1},
    {'c': 84, 'w': 100, 'm': 1},
    {'c': 85, 'w': 100, 'm': 1},
    {'c': 86, 'w': 100, 'm': 1},
    {'c': 87, 'w': 100, 'm': 1},
    {'c': 88, 'w': 100, 'm': 1},
    {'c': 89, 'w': 100, 'm': 1},
    {'c': 90, 'w': 100, 'm': 1},
    {'c': 91, 'w': 100, 'm': 1},
    {'c': 92, 'w': 100, 'm': 1},
    {'c': 93, 'w': 100, 'm': 1},
    {'c': 94, 'w': 100, 'm': 1},
    {'c': 95, 'w': 100, 'm': 1},
    {'c': 96, 'w': 100, 'm': 1},
    {'c': 97, 'w': 100, 'm': 1},
    {'c': 98, 'w': 100, 'm': 1},
    {'c': 99, 'w': 100, 'm': 1},
    {'c': 200, 'w': 50, 'm': 1}
]


# константы 
#S = 250
S = 10500
ENABLE_TEST_FLAG = 0
ENABLE_PARAM_SEARCH = 0
ENABLE_MULTIPROCESSING = 1

def timer(func):
    def wrapper(*args, **kwargs):
        start_time = perf_counter()
        result = func(*args, **kwargs)
        end_time = perf_counter()
        exec_time = end_time - start_time
        print(f"Function '{func.__name__}' executed in {exec_time:.4f} seconds.")
        return result
    return wrapper

def roulette(P: float):
    return random() < P

def knapsack_test(SAMPLES, capacity):
    items = []
    for obj in SAMPLES:
        cost = obj["c"]
        weight = obj["w"]
        min_count = obj["m"]
        itemInfo = {
            'cost': cost,
            'weight': weight,
            'min_count': min_count,
            'cost_per_weight': cost / weight,
            'index': SAMPLES.index(obj)
        }
        items.append(itemInfo)
    
    items.sort(key=lambda x: x['cost_per_weight'], reverse=True)
    
    total_cost = 0
    used_capacity = 0
    solution_vector = [0] * len(SAMPLES)
    
    for idx, item in enumerate(items):
        required_weight = item['weight'] * item['min_count']
        
        if used_capacity + required_weight <= capacity:
            total_cost += item['cost'] * item['min_count']
            used_capacity += required_weight
            solution_vector[item["index"]] = item['min_count']
        else:
            print("Impossible to fit minimum")
    
    free_space = capacity - used_capacity
    for idx, item in enumerate(items):
        if free_space <= 0:
            break
        
        possible_count = free_space // item['weight']
        additional_count = possible_count
        
        if additional_count > 0:
            total_cost += item['cost'] * additional_count
            free_space -= additional_count * item['weight']
            solution_vector[item["index"]] += additional_count
    
    return total_cost, solution_vector

class StabilizationNotReached(Exception):
    pass

class Entity():
    package = []

    def __init__(self, genetation, package=[]):
        global SAMPLES
        global S
        self.gen = genetation
        self.eid = genetation.eid
        self.gid = genetation.eid
        genetation.eid += 1
        if package != []:
            self.package = package
        else:
            self.package = [SAMPLES[i]["m"] for i in range(len(SAMPLES))]
        self.S = S - sum(SAMPLES[i]["w"] * self.package[i] for i in range(len(self.package)))
        self.Fill()
        if not self._check():
            self.refill()

    def refill(self):
        self.package = [SAMPLES[i]["m"] for i in range(len(SAMPLES))]
        self.S = S - sum(SAMPLES[i]["w"] * self.package[i] for i in range(len(self.package)))
        self.Fill()

    def __lt__(self, other):
        return self.Score() < other.Score()

    def __eq__(self, other):
        return self.Score() == other.Score()

    def __gt__(self, other):
        return self.Score() > other.Score()

    def __ge__(self, other):
        return self.Score() >= other.Score()

    def __le__(self, other):
        return self.Score() <= other.Score()

    def Score(self):
        global SAMPLES
        return sum(SAMPLES[i]["c"] * self.package[i] for i in range(len(self.package)))
    
    def _check(self):
        global SAMPLES
        for i in range(len(self.package)):
            if self.package[i] < SAMPLES[i]['m']:
                return False
            if self.S < 0:
                return False
        return True
    
    def FreeSpace(self):
        return self.S

    def HasSpace(self): 
        global SAMPLES
        return self.S >= min(x["w"] for x in SAMPLES)

    def Fill(self):
        global SAMPLES
        while self.HasSpace():
            for i in range(len(self.package)):
                if roulette(self.gen.P_fill) and self.S >= SAMPLES[i]["w"]:
                    self.package[i] += 1
                    self.S -= SAMPLES[i]["w"]
                    if not self._check():
                        self.refill()

    def Mutate(self):
        global SAMPLES
        if roulette(self.gen.P_mut):
            StateChanged = False
            old_package = self.package.copy()
            while not StateChanged:
                for i in range(len(self.package)):
                    if roulette(self.gen.P_del):
                        self.package[i] -= 1
                        self.S += SAMPLES[i]['w']
                        StateChanged = True
            self.Fill()
            if not self._check():
                self.package = old_package

    def HaveBaby(self, parent):
        global SAMPLES
        if not roulette(self.gen.P_born):
            return None
        
        r = [self.package[i] if self.package[i] == parent.package[i] else SAMPLES[i]["m"] for i in range(len(self.package))]
        child = Entity(self.gen, package=r)
        child.Fill()
        
        if not child._check():
            return None
        child.Mutate()
        return child

def qsort(arr):
    if len(arr) <= 1:
        return arr
    t = arr[len(arr) // 2]
    left = [x for x in arr if x > t]
    mid = [x for x in arr if x == t]
    right = [x for x in arr if x < t]
    return qsort(left) + mid + qsort(right)

class GenerationFactory():
    N = 100
    STOP = 50
    P_fill = 0.1
    P_del = 0.1
    P_born = 0.1
    P_mut = 0.5
    OPT_MAX = 20
    ELITE_PERCENT = 0.5
    MIGRANT_COUNT = 20
    DISABLE_GENERATION_PRINTER = 1

    def GetGenBest(self):
        return self.population[0]
    
    def __init__(self, N=100, STOP=10, P_fill=0.4, P_del=0.5, P_born=0.6, P_mut=0.4, OPT_MAX=50, ELITE_PERCENT=0.2):
        self.population = []
        self.eid = 0
        self.gid = 1
        self.best = None

    def GenerateFirst(self):
        while len(self.population) < self.N:
            self.population.append(Entity(self))
            self.eid += 1
        self.population = qsort(self.population)
        self.best = self.GetGenBest()
        self.gid += 1

    def SplitPopulation(self):
        p20 = floor(self.N * self.ELITE_PERCENT)
        best = self.population[:p20]
        worst = self.population[p20:]
        return (best, worst)
    
    def NewGen(self, migrants_received=None):
        if not self.DISABLE_GENERATION_PRINTER:
            print(f"Новое поколение {self.gid}")
        if self.gid > self.STOP:
            raise StabilizationNotReached("[END] Stabilization not reached stopping due to limitation of iterations")

        best, worst = self.SplitPopulation()
        while len(self.population) < self.N * 2:
            p1 = choice(best)
            p2 = choice(worst)
            c = p1.HaveBaby(p2)
            if c is None:
                continue
            self.eid += 1
            self.population.append(c)
        
        self.population = qsort(self.population)
        
        if ENABLE_MULTIPROCESSING and migrants_received is not None:
            new_gen = self.population[:self.N - self.MIGRANT_COUNT]
            # Сохраняем мигрантов для отправки
            migrants_to_send = [(entity.Score(), entity.package) for entity in self.population[self.N - self.MIGRANT_COUNT:self.N]]
            
            # Добавляем полученных мигрантов
            migrants_entities = []
            for score, package in migrants_received:
                migrant_entity = Entity(self, package=package)
                migrants_entities.append(migrant_entity)
            
            new_gen.extend(migrants_entities)
            self.population = new_gen
            self.population = qsort(self.population)[:self.N]
            
            # Возвращаем мигрантов для отправки
            return migrants_to_send
        else:
            self.population = self.population[:self.N]
        
        self.gid += 1
        self.population = qsort(self.population)
        best = self.GetGenBest()

        if not self.DISABLE_GENERATION_PRINTER:
            print(f"[{self.gid}][INFO] Generation Created: Score: {best.Score()} Load: {best.package}")
        return best, None

def run_single_ga_process(process_id, migrant_queues):
    """
    Запускает один генетический алгоритм в отдельном процессе
    """
    print(f"Процесс {process_id} запущен")
    
    factory = GenerationFactory()
    factory.GenerateFirst()
    old = factory.best
    OPT_MAX = factory.OPT_MAX
    opt = 0
    
    # Очередь для отправки мигрантов
    my_send_queue = migrant_queues[process_id]
    
    while True:
        try:
            # Получаем мигрантов от других процессов
            migrants_received = []
            for i, recv_queue in enumerate(migrant_queues):
                if i != process_id:  # Не читаем из своей очереди
                    try:
                        while True:  # Забираем всех доступных мигрантов
                            migrant = recv_queue.get(block=False)
                            migrants_received.extend(migrant)
                    except queue.Empty:
                        pass
            
            # Создаем новое поколение
            result = factory.NewGen(migrants_received if migrants_received else None)
            
            if isinstance(result, tuple) and len(result) == 2:
                new, migrants_to_send = result
            else:
                new = result
                migrants_to_send = None
            
            # Отправляем мигрантов
            if migrants_to_send and len(migrants_to_send) > 0:
                my_send_queue.put(migrants_to_send)
            
        except StabilizationNotReached:
            print(f"Процесс {process_id}: Best: {new.Score()} With solution: {new.package}")
            return (new.Score(), new.package, process_id)

        if old >= new:
            opt += 1
            if opt >= OPT_MAX:
                print(f"Процесс {process_id}: Stabilization Reached")
                print(f"Процесс {process_id}: Best: {old.Score()} With solution: {old.package}")
                return (old.Score(), old.package, process_id)
        else:
            old = new
            opt = 0

class ProcManager():
    def __init__(self):
        self.PROC_COUNT = min(multiprocessing.cpu_count(), 1000)  # Ограничиваем количество процессов
        self.results = []
    @timer
    def start(self):
        """Запускает несколько независимых процессов с обменом мигрантами"""
        print(f"Запуск {self.PROC_COUNT} процессов")
        
        # Создаем очереди для обмена мигрантами между процессами
        manager = multiprocessing.Manager()
        migrant_queues = [manager.Queue() for _ in range(self.PROC_COUNT)]
        
        # Создаем и запускаем процессы
        with ProcessPoolExecutor(max_workers=self.PROC_COUNT) as executor:
            # Запускаем все процессы
            futures = {
                executor.submit(run_single_ga_process, i, migrant_queues): i 
                for i in range(self.PROC_COUNT)
            }
            
            # Собираем результаты
            for future in as_completed(futures):
                try:
                    result = future.result(timeout=300)
                    self.results.append(result)
                    print(f"Процесс {result[2]} завершился с результатом: {result[0]}")
                except Exception as e:
                    print(f"Процесс завершился с ошибкой: {e}")
    
    def get_best(self):
        """Возвращает лучший результат"""
        if not self.results:
            print("Нет результатов для анализа")
            return None
        
        best = sorted(self.results, key=lambda x: x[0])
        best_result = best[-1]
        print(f"Лучший: {best_result[0]} с параметрами {best_result[1]} (от процесса {best_result[2]})")
        return best_result

def run_one_test(current_params, expected, max_iter_test):
    start_time = time()
    gf = GenerationFactory(**current_params)
    best_score = 10000000
    best_params = current_params
    try:
        for _ in range(max_iter_test):
            best_entity, _ = gf.NewGen()
            score = abs(best_entity.Score() - expected)
            if score < best_score:
                best_score = score
                best_params = current_params
    except Exception as e:
        print(f"Ошибка: {e}")
        return {'score': best_score, 'params': best_params}
    
    elapsed_time = time() - start_time
    result = {'score': best_score, 'elapsed_time': elapsed_time, 'params': best_params}
    return result

def parallel_grid_search(params_grid, max_iter_test, expected, num_processes=None):
    keys, values = zip(*params_grid.items())
    combinations = list(itertools.product(*values))
    param_combinations = [dict(zip(keys, combo)) for combo in combinations]
    
    partial_func = functools.partial(run_one_test, expected=expected, max_iter_test=max_iter_test)

    with multiprocessing.Pool(processes=num_processes) as pool:
        results = pool.map(partial_func, param_combinations)

    best_result = sorted(results, key=lambda r: r['score'])[0]
    return results

def plot_parameter_influence(results):
    df_results = pd.DataFrame([{'score': res['score']} | res['params'] for res in results])
    parameter_names = [col for col in df_results.columns if col != 'score']

    for param_name in parameter_names:
        grouped_data = df_results.groupby(param_name)['score'].mean().reset_index()
        plt.figure(figsize=(10, 6))
        plt.plot(grouped_data[param_name], grouped_data['score'], marker='o', linestyle='-', color='b')
        plt.title(f'Зависимость среднего балла от параметра "{param_name}"')
        plt.xlabel(param_name)
        plt.ylabel('Средняя оценка')
        plt.grid(True)
        plt.show()

def plot_heatmaps_by_pairs(results):
    df_results = pd.DataFrame([{'score': res['score']} | res['params'] for res in results])
    parameter_names = [col for col in df_results.columns if col != 'score']

    from itertools import combinations
    pairs = list(combinations(parameter_names, 2))

    for pair in pairs:
        pivot_table = df_results.pivot_table(index=pair[0], columns=pair[1], values='score', aggfunc='mean')
        plt.figure(figsize=(10, 8))
        sns.heatmap(pivot_table, annot=True, cmap="YlGnBu", fmt=".2f", linewidths=.5)
        plt.title(f'Тепловая карта: {pair[0]} vs {pair[1]}')
        plt.show()

@timer
def main():
    """Основная функция для одиночного запуска"""
    factory = GenerationFactory()
    factory.GenerateFirst()
    old = factory.best
    OPT_MAX = factory.OPT_MAX
    opt = 0
    
    while True:
        try:
            new, _ = factory.NewGen()
        except StabilizationNotReached:
            print(f"Best: {new.Score()} With solution: {new.package}")
            return (new.Score(), new.package)

        if old >= new:
            opt += 1
            print(f"[STAB] current optimum {opt}")
            if opt >= OPT_MAX:
                print(f"[{factory.gid}][END] Stabilization Reached")
                print(f"Best: {old.Score()} With solution: {old.package}")
                return (old.Score(), old.package)
        else:
            old = new
            opt = 0

if __name__ == "__main__":
    if ENABLE_TEST_FLAG:
        result, solution = knapsack_test(SAMPLES, S)
        print(f"Общая стоимость: {result}")
        print(f"Вектор решений: {solution}")
    elif ENABLE_PARAM_SEARCH:
        param_grid = {
            'N': [100],
            'STOP': [200],
            'P_fill': [0.3, 0.4, 0.5],
            'P_del': [0.4, 0.5, 0.6],
            'P_born': [0.5, 0.6, 0.7],
            'P_mut': [0.3, 0.4, 0.5],
            'OPT_MAX': [50],
            'ELITE_PERCENT': [0.1, 0.2, 0.3]
        }
        results = parallel_grid_search(param_grid, 30, 375)
        best_result = sorted(results, key=lambda r: r['score'])[0]
        print(best_result)
        plot_parameter_influence(results)
        plot_heatmaps_by_pairs(results)
    elif ENABLE_MULTIPROCESSING:
        manager = ProcManager()
        manager.start()
        best_result = manager.get_best()
    else:
        main()
