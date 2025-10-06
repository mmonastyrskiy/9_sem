
import functools
import itertools
import multiprocessing
from random import random,seed,choice
from time import time,perf_counter
from math import floor
from tqdm import tqdm

seed(time()) # инициализация ГПСЧ

"""
# Данные задачи
SAMPLES = [
    {"c": 5, "w": 10, "m": 1},
    {"c": 4, "w": 15, "m": 1},
    {"c": 3, "w": 20, "m": 1},
    {"c": 5, "w": 25, "m": 1},
    {"c": 5, "w": 20, "m": 2},
    {"c": 2, "w": 10, "m": 1},
    {"c": 20, "w": 5, "m": 2},
    {"c": 1, "w": 25, "m": 1},
    {"c": 3, "w": 10, "m": 1},
    {"c": 2, "w": 10, "m": 1}
]



"""

## ОПТ 375
SAMPLES = [
    {"c": 5, "w": 10, "m": 1},
    {"c": 4, "w": 15, "m": 1},
    {"c": 3, "w": 20, "m": 1},
    {"c": 5, "w": 25, "m": 1},
    {"c": 5, "w": 20, "m": 2},
    {"c": 2, "w": 10, "m": 1},
    {"c": 20, "w": 5, "m": 2},
    {"c": 1, "w": 25, "m": 1},
    {"c": 3, "w": 10, "m": 1},
    {"c": 2, "w": 10, "m": 1}
]
"""

SAMPLES = [
    {'c': 45, 'w': 12, 'm': 1},
    {'c': 78, 'w': 23, 'm': 0},
    {'c': 15, 'w': 5, 'm': 1},
    {'c': 92, 'w': 34, 'm': 2},
    {'c': 33, 'w': 8, 'm': 0},
    {'c': 67, 'w': 19, 'm': 1},
    {'c': 21, 'w': 7, 'm': 1},
    {'c': 54, 'w': 15, 'm': 0},
    {'c': 88, 'w': 28, 'm': 1},
    {'c': 12, 'w': 3, 'm': 2},
    {'c': 76, 'w': 22, 'm': 1},
    {'c': 39, 'w': 11, 'm': 0},
    {'c': 95, 'w': 31, 'm': 1},
    {'c': 28, 'w': 9, 'm': 1},
    {'c': 61, 'w': 17, 'm': 0},
    {'c': 83, 'w': 25, 'm': 2},
    {'c': 17, 'w': 6, 'm': 1},
    {'c': 49, 'w': 14, 'm': 0},
    {'c': 72, 'w': 21, 'm': 1},
    {'c': 36, 'w': 10, 'm': 1},
    {'c': 99, 'w': 32, 'm': 0},
    {'c': 24, 'w': 8, 'm': 2},
    {'c': 57, 'w': 16, 'm': 1},
    {'c': 81, 'w': 24, 'm': 0},
    {'c': 42, 'w': 13, 'm': 1},
    {'c': 68, 'w': 20, 'm': 1},
    {'c': 31, 'w': 9, 'm': 0},
    {'c': 74, 'w': 22, 'm': 2},
    {'c': 19, 'w': 7, 'm': 1},
    {'c': 53, 'w': 15, 'm': 0},
    {'c': 87, 'w': 26, 'm': 1},
    {'c': 14, 'w': 4, 'm': 1},
    {'c': 65, 'w': 18, 'm': 0},
    {'c': 91, 'w': 29, 'm': 2},
    {'c': 27, 'w': 8, 'm': 1},
    {'c': 59, 'w': 16, 'm': 0},
    {'c': 84, 'w': 25, 'm': 1},
    {'c': 38, 'w': 11, 'm': 1},
    {'c': 71, 'w': 20, 'm': 0},
    {'c': 96, 'w': 30, 'm': 2},
    {'c': 22, 'w': 7, 'm': 1},
    {'c': 56, 'w': 15, 'm': 0},
    {'c': 79, 'w': 23, 'm': 1},
    {'c': 34, 'w': 10, 'm': 1},
    {'c': 63, 'w': 17, 'm': 0},
    {'c': 89, 'w': 27, 'm': 2},
    {'c': 16, 'w': 5, 'm': 1},
    {'c': 51, 'w': 14, 'm': 0},
    {'c': 77, 'w': 22, 'm': 1},
    {'c': 32, 'w': 9, 'm': 1},
    {'c': 69, 'w': 19, 'm': 0},
    {'c': 94, 'w': 29, 'm': 2},
    {'c': 25, 'w': 8, 'm': 1},
    {'c': 58, 'w': 16, 'm': 0},
    {'c': 82, 'w': 24, 'm': 1},
    {'c': 37, 'w': 11, 'm': 1},
    {'c': 64, 'w': 18, 'm': 0},
    {'c': 97, 'w': 30, 'm': 2},
    {'c': 18, 'w': 6, 'm': 1},
    {'c': 52, 'w': 14, 'm': 0},
    {'c': 75, 'w': 21, 'm': 1},
    {'c': 29, 'w': 9, 'm': 1},
    {'c': 62, 'w': 17, 'm': 0},
    {'c': 86, 'w': 26, 'm': 2},
    {'c': 13, 'w': 4, 'm': 1},
    {'c': 48, 'w': 13, 'm': 0},
    {'c': 73, 'w': 21, 'm': 1},
    {'c': 35, 'w': 10, 'm': 1},
    {'c': 66, 'w': 18, 'm': 0},
    {'c': 93, 'w': 28, 'm': 2},
    {'c': 26, 'w': 8, 'm': 1},
    {'c': 55, 'w': 15, 'm': 0},
    {'c': 78, 'w': 23, 'm': 1},
    {'c': 41, 'w': 12, 'm': 1},
    {'c': 47, 'w': 13, 'm': 0},
    {'c': 85, 'w': 25, 'm': 2},
    {'c': 23, 'w': 7, 'm': 1},
    {'c': 50, 'w': 14, 'm': 0},
    {'c': 76, 'w': 22, 'm': 1},
    {'c': 30, 'w': 9, 'm': 1},
    {'c': 60, 'w': 16, 'm': 0},
    {'c': 90, 'w': 27, 'm': 2},
    {'c': 20, 'w': 6, 'm': 1},
    {'c': 43, 'w': 12, 'm': 0},
    {'c': 70, 'w': 20, 'm': 1},
    {'c': 40, 'w': 11, 'm': 1},
    {'c': 44, 'w': 12, 'm': 0},
    {'c': 80, 'w': 23, 'm': 2},
    {'c': 11, 'w': 3, 'm': 1},
    {'c': 46, 'w': 13, 'm': 0},
    {'c': 74, 'w': 21, 'm': 1},
    {'c': 31, 'w': 9, 'm': 1},
    {'c': 58, 'w': 16, 'm': 0},
    {'c': 84, 'w': 24, 'm': 2},
    {'c': 19, 'w': 6, 'm': 1},
    {'c': 54, 'w': 15, 'm': 0},
    {'c': 72, 'w': 20, 'm': 1},
    {'c': 33, 'w': 10, 'm': 1},
    {'c': 65, 'w': 18, 'm': 0},
    {'c': 98, 'w': 31, 'm': 2}
]
"""
# константы 
S = 250
ENABLE_TEST_FLAG = 0 # Выключатель тестов
ENABLE_PARAM_SEARCH = 1


def timer(func):
    def wrapper(*args, **kwargs):
        start_time = perf_counter()
        result = func(*args,**kwargs)
        end_time = perf_counter()
        exec_time = end_time - start_time
        print(f"Function '{func.__name__}' executed in {exec_time:.4f} seconds.")
        return result
    return wrapper

def roulette(P: float):
    return random() < P # Реализация функции активации на основе ГПСЧ


def knapsack_test(SAMPLES, capacity):
    """
    функция для теста, работает методами ДП
    """
    # Подготовим объекты для удобной работы
    items = []
    for obj in SAMPLES:
        cost = obj["c"]  # стоимость
        weight = obj["w"]  # вес
        min_count = obj["m"]  # минимальное количество
        itemInfo = {
            'cost': cost,
            'weight': weight,
            'min_count': min_count,
            'cost_per_weight': cost / weight,
            'index':SAMPLES.index(obj)
        }
        items.append(itemInfo)
    
    # Сортируем предметы по убыванию отношения стоимости к весу
    items.sort(key=lambda x: x['cost_per_weight'], reverse=True)
    
    # Переменные для накопления результатов
    total_cost = 0
    used_capacity = 0
    solution_vector = [0] * len(SAMPLES)
    
    # Основной цикл упаковки рюкзака
    for idx, item in enumerate(items):
        # Требуемый вес для соблюдения минимального количества
        required_weight = item['weight'] * item['min_count']
        
        # Можно ли уместить минимальный набор?
        if used_capacity + required_weight <= capacity:
            # Вносим минимальное количество предмета
            total_cost += item['cost'] * item['min_count']
            used_capacity += required_weight
            solution_vector[item["index"]] = item['min_count']
        else:
            # Если не получается внести минимум, пропускаем предмет
            print("Impossible to fit minimum")
    
    # Остаточный ресурс распределяется дальше
    free_space = capacity - used_capacity
    for idx, item in enumerate(items):
        # Доступное пространство исчерпано
        if free_space <= 0:
            break
        
        # Сколько штук ещё можно уложить
        possible_count = free_space // item['weight']
        
        # Взять не больше, чем нужно
        additional_count = possible_count
        
        if additional_count > 0:
            # Добавляем новую партию предмета
            total_cost += item['cost'] * additional_count
            free_space -= additional_count * item['weight']
            solution_vector[item["index"]] += additional_count
    
    return total_cost, solution_vector



class StabilizationNotReached(Exception):
    """
    Определение исключения для отлова момента прекращения алгоритма при превышении количества итераций
    """
    pass



class Entity(): # Класс - особь
    package = [] # Решение для текущей особи

    def __init__(self,genetation,package=[]): # Конструктор класса
        """
        Реализует два варианта создания сущностей
        с пустым рюкзаком - первое поколение
        с заранее готовым вектором, при наследовании решения от родителей
        """
        global SAMPLES
        global S
        self.gen = genetation
        self.eid = genetation.eid # ID Сущности
        self.gid =genetation.eid # Номер поколения
        genetation.eid +=1
        if package != []: # ветвление для разных вариантов создания сущности
            self.package = package
        else:
            self.package = [SAMPLES[i]["m"] for i in range(len(SAMPLES)) ] # Рюкзак изначально заполняется минимальным количеством объектов
        self.S = S - sum(SAMPLES[i]["w"] * self.package[i] for i in range(len(self.package))) # Пересчитываем нагрузку, перезаписываем свободное место в сущности
        self.Fill() # Запускаем алгоритм заполнения
        if not self._check():
            self.refill()

        

    def refill(self):
        self.package = self.package = [SAMPLES[i]["m"] for i in range(len(SAMPLES)) ]
        self.S = S - sum(SAMPLES[i]["w"] * self.package[i] for i in range(len(self.package)))
        self.Fill()


    def __lt__(self, other):
        return self.Score() < other.Score()
    def __eq__(self, other):
        return self.Score() == other.Score()
    def __gt__(self,other):
        return self.Score() > other.Score()
    def __ge__(self,other): # определяем операторы >= для сущности на основе ценности рюзкака 
        return self.Score() >= other.Score()
    def __le__(self,other):# определяем операторы <= для сущности на основе ценности рюзкака 
        return self.Score() <= other.Score()
    ## Определение операторов нужно для реализации сортировки

    def Score(self):
        """
        общая стоимость рюкзака
        """
        global SAMPLES
        return sum(SAMPLES[i]["c"] * self.package[i] for i in range(len(self.package)))
    
    def _check(self):
        """
        Проверка допустимости решения
        """
        global SAMPLES
        for i in range(len(self.package)):
            if self.package[i] < SAMPLES[i]['m']:
                return False # если один из элементов рюкзака меньше минимального
            if self.S < 0: # Вес рюкзака не превышает S
                return False

        return True
    
    def FreeSpace(self):
        return self.S # Текущий свободный вес
    def HasSpace(self): 
        global SAMPLES
        return self.S >= min(x["w"] for x in SAMPLES) # Места хватает чтобы положить что-то еще
    def Fill(self):
        """
        Функция заполнения рюкзака
        """

        global SAMPLES
        while self.HasSpace(): # Пока можем положить что-то еще в рюкзак
            for i in range(len(self.package)): # Итерируемся по рюкзаку 
                if roulette(self.gen.P_fill) and self.S >= SAMPLES[i]["w"]: # Если объект нужно положить и он помещается
                    self.package[i]+=1 #Увеличиваем кол-во
                    self.S -= SAMPLES[i]["w"] # Пересчитываем вес
                    #print(f"[{self.gid}][LOAD] Object {i} is loaded into entity {self.eid} currennt load = {self.package}") # Выводим запись в консоль
                    if not self._check():
                        self.refill()
    def Mutate(self):
        """
        Функция мутации 
        """

        global SAMPLES
        if roulette(self.gen.P_mut): # Если нужно мутировать
            StateChanged = False #Флаг для гарантии внесения изменений в рюкзак
            old_package = self.package
            while not StateChanged: # Пока рюкзак не изменится 
                for i in range(len(self.package)): # Ходим по рюкзаку
                    if roulette(self.gen.P_del): # Пробуем вытащить каждый из элментов 
                        self.package[i] -=1 # Если вытащился, уменьшаем кол-во элементов
                        self.S += SAMPLES[i]['w'] # Пересчитываем пустой вес
                        StateChanged = True # Устанавливаем флаг изменения состояния 
        self.Fill() # Перезаполняем рюкзак
        if not self._check():
            self.package = old_package
        #print(f"[{self.gid}][MUT] Mutation happed to {self.eid} new package: {self.package}") # Выводим запись в консоль



    def HaveBaby(self,parent):
        """
        Функция "Деторождения"
        parent - второй родитель
        childid - ID присваеваемый ребенку
        """
        global SAMPLES
        if not roulette(self.gen.P_born):
            #print(f"[{self.gid}][BORN]No baby =( ")
            return None # Если детей не будет, выходим из функции 
        
        r = [self.package[i] if self.package[i]== parent.package[i] else SAMPLES[i]["m"] for i in range(len(self.package))] # Создаем наследованное решение, общие значения родителей сохраняем, в противном случае ставим минимум
        child = Entity(self.gen,package=r) # Создаем особь с созданным решением
        child.Fill() # Дозаполняем рюкзак
        
        if not child._check(): # Если конечное решение недопустимое - выходим без ребенка
            #print(f"[{self.gid}][BORN] Invalid Child {self.package} {self.S}")
            return None
        #print(f"[{self.gid}][BORN] Parents {self.eid} and {parent.eid} has born a child {child.eid} with package: {child.package}") # Выводим запись в консоль
        child.Mutate() # Пробуем мутировать ребенка 
        return child # Возвращаем результат
    

def qsort(arr):
    """
    Функция реализует рекурсивынй алгоритм быстрой сортировки
    arr -  Массив особей
    """
    if len(arr) <= 1:
        return arr
    t = arr[len(arr)//2]
    left = [x for x in arr if x > t]
    mid = [x for x in arr if x == t]
    right = [x for x in arr if x < t]
    return qsort(left) + mid + qsort(right)


class GenerationFactory(): # Класс - Поколение
    N = 100
    STOP = 200 # Максимальное количество итераций 
    P_fill = 0.4 # Вероятность вставить предмет в рюкзак
    P_del = 0.5 # Вероятность удалить предмет из рюкзака
    P_born = 0.6 # Вероятность дать потомство
    P_mut = 0.4 # Вероятность мутации
    OPT_MAX = 50 # Количество поколений без изменений до остановки алгоритма
    ELITE_PERCENT = 0.2 # Процент элиты при делении поколений
    DISABLE_GENERATION_PRINTER = 1

    def GetGenBest(self):
        return self.population[0] # Получаем лучшее решение в отсортированном массиве особей
    
    def __init__(self,N,STOP,P_fill,P_del,P_born,P_mut,OPT_MAX,ELITE_PERCENT):

        self.N = N if N is not None else self.N
        self.STOP = STOP if STOP is not None else self.STOP
        self.P_fill = P_fill if P_fill is not None else self.P_fill
        self.P_del = P_del if P_del is not None else self.P_del
        self.P_born = P_born if P_born is not None else self.P_born
        self.P_mut = P_mut if P_mut is not None else self.P_mut
        self.OPT_MAX = OPT_MAX if OPT_MAX is not None else self.OPT_MAX
        self.ELITE_PERCENT = ELITE_PERCENT if ELITE_PERCENT is not None else self.ELITE_PERCENT




        self.population = [] # Массив особей поколения 
        self.eid = 0 # Текущий ID особ/и
        self.gid = 1 # Номер текущего поколения
        self.best = None # Текущее лучшее решение
        while len(self.population) < self.N: # Пока в поколении не хватает особей создаем новые
            self.population.append(Entity(self))
            self.eid +=1
        self.population = qsort(self.population) # Сортируем особей в поколении по убыванию конечной стоимости
        self.best = self.GetGenBest() # Получаем лучшее решение и сохраняем
        self.gid +=1 # Увеличиваем номер поколения 


    
    def SplitPopulation(self): # Разбиваем поколение в соотношении 20/80 с округлением в меньшую сторону

        p20 = floor(self.N*self.ELITE_PERCENT) # вычисляем индекс разбиения
        best = self.population[:p20] # Первые 20%
        worst = self.population[p20:] # прочее
        return (best,worst)
    
    def NewGen(self):
        """
        Функция генерации нового поколенiidия 
        """
        if not self.DISABLE_GENERATION_PRINTER:
            print(f"Новое поколение {self.gid}")
        if self.gid > self.STOP: # Если номер поколения превышает максимум прерываемся с сообщением в консоль
            raise StabilizationNotReached("[END] Stabilization not reached stopping due to limitation of itterations ")


        best, worst = self.SplitPopulation()  # Разбиваем текущее поколение на лучших и худших
        while len(self.population) < self.N*2:
            p1 = choice(best)  # Случайный родитель из лучших
            p2 = choice(worst)  # случайный родитель из худших
            #print(f"Пытаемся родить: Выбранные родители {p1.eid}  {p2.eid} ")
            c = p1.HaveBaby(p2)  # Пытаемся родить потомка
            if c is None:  # Если не родился перезапускаем цикл, ищем новых родителей
                continue
            self.eid += 1  # В противном случае увеличиваем текущий индекс ребенка
            self.population.append(c)  # Записываем ребенка в новое поколение
        self.population = qsort(self.population)
        new_gen = self.population[:self.N]
        self.gid += 1  # По завершении генерации увеличиваем номер поколения
        new_gen = qsort(new_gen)  # сортируем результат
        self.population = new_gen  # делаем новое поколение основным
        best = self.GetGenBest()  # получаем лучший результат

        if not self.DISABLE_GENERATION_PRINTER:
            print(
                f"[{self.gid}][INFO] Generaton Created: Score: {best.Score()} Load: {best.package}")  # Выводим лучшую особь из поколения
        return best  # Возвращаем его из функции

"""
def grid_search(params_grid,max_iterations_per_run,expected):
    """
"""
    params_grid - словарь, содержащий диапазоны гиперпараметров для перебора
    sample - задача
    expected - ожидаемое значение решения
    """
"""
    best_params = {}
    best_score = float('+inf')  # Начальная оценка качества (чем меньше, тем лучше)

    # Перебираем комбинации всех возможных значений гиперпараметров
    keys, values = zip(*params_grid.items())
    combinations = list(itertools.product(*values))

    for combination in tqdm(combinations):
        current_params = dict(zip(keys, combination))  # Текущие гиперпараметры
        #print(f"Тестируем комбинацию: {current_params}")

        # Создаем экземпляр класса GenerationFactory с текущими параметрами
        gf = GenerationFactory(**current_params)

        try:
            for _ in range(max_iterations_per_run):
                best_entity = gf.NewGen()  # Создание нового поколения
                score = abs(best_entity.Score()-expected)  # Оценка лучшего решения
                
                # Проверяем, улучшилась ли лучшая оценка
                if score < best_score:
                    best_score = score
                    best_params = current_params.copy()
                    
        except Exception as e:
            print(f"Ошибка: {e}")
            break

    return best_params, best_score
    """
def run_one_test(current_params,expected,max_iter_test):
    start_time = time()
    gf = GenerationFactory(**current_params)
    best_score = 10000000
    try:
        for _ in range(max_iter_test):
            best_entity = gf.NewGen()
            score = abs(best_entity.Score()-expected)
            if score < best_score:
                best_score = score
                best_params = current_params
    except Exception as e:
        print(f"Ошибка: {e}")
        return {'score': best_score, 'params': best_params}
    
    elapsed_time = time() - start_time
    result = {'score': best_score, 'elapsed_time': elapsed_time, 'params': best_params}
    return result

def parallel_grid_search(params_grid,max_iter_test,expected, num_processes=None):
    """
    Параллельный поиск гиперпараметров.
    :param params_grid: Словарь с сеткой гиперпараметров
    :param num_processes: Число процессов (если None, используется значение равное числу ядер CPU)
    """
    # Генерируем все комбинации гиперпараметров
    keys, values = zip(*params_grid.items())
    combinations = list(itertools.product(*values))
    param_combinations = [dict(zip(keys, combo)) for combo in combinations]
    partial_func = functools.partial(run_one_test, expected=expected)
    partial_func2 = functools.partial(partial_func,max_iter_test=max_iter_test)

    with multiprocessing.Pool(processes=num_processes) as pool:
        results = pool.map(partial_func2, param_combinations)

    # Агрегируем результаты
    best_result = sorted(results, key=lambda r: r['score'])[0]
    return best_result

@timer
def main():
    """
    Основная функция программы
    """
    factory = GenerationFactory() # Создаем генератор поколений и первое поколение
    old = factory.best # Записываем результат текущего поколения
    OPT_MAX = factory.OPT_MAX
    opt = 0
    while True: # Бесконечный цикл
        try:
            new = factory.NewGen() # Пытаемся создать новое поколение и записываем лучшего из него
        except StabilizationNotReached:
            print(f"Best: {new.Score()} With solution: {new.package}") # Обрабатывсаем верхнюю границу количества поколений 
            break


        if old >= new: # Если текущий не хуже нового прерываемся,стабилизация достигнута 
            opt +=1
            print(f"[STAB] current optimum {opt}")
            if opt >= OPT_MAX:
                print(f"[{factory.gid}][END] Stabilization Reached") # Выводим запись в консоль
                print(f"Best: {old.Score()} With solution: {old.package}")# Выводим полученное решение
                break # выходим из программы
        else:
            old = new # Если на этом поколении решения не нашлось, то делаем новое поколение текущим.
            opt = 0
            print(f"[STAB] current optimum reset {opt}")

if __name__ == "__main__":
    if ENABLE_TEST_FLAG:
        result,solution = knapsack_test(SAMPLES,S)
        print(f"Общая стоимость: {result}")
        print(f"Вектор решений: {solution}")
    elif ENABLE_PARAM_SEARCH:
        param_grid = {
    'N': [100],
    'STOP': [200],
    'P_fill': [0.3, 0.4, 0.5],      # Вероятность добавления предмета
    'P_del': [0.4, 0.5, 0.6],       # Вероятность удаления предмета
    'P_born': [0.5, 0.6, 0.7],      # Вероятность появления потомства
    'P_mut': [0.3, 0.4, 0.5],       # Вероятность мутации
    'OPT_MAX': [50],
    'ELITE_PERCENT': [0.1, 0.2, 0.3]   # Доля элитных особей
}
        #print(grid_search(param_grid,30,375))
        print(parallel_grid_search(param_grid,30,375))
    else:
        main() # Точка входа в программу

