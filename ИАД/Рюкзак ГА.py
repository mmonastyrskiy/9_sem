
import functools
import itertools
import multiprocessing
from random import random,seed,choice
from time import time,perf_counter
from math import floor
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from concurrent.futures import ThreadPoolExecutor
from time import sleep

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
"""
# константы 
S = 250
# S = 10500
ENABLE_TEST_FLAG = 0 # Выключатель тестов
ENABLE_PARAM_SEARCH = 0
ENABLE_MULTIPROCESSING = 1



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


import multiprocessing

class ProcManager():
    PROC_COUNT = 30           # Количество процессов по умолчанию
    processes = []            # Список запущенных процессов
    storage = []              # Хранение результатов выполнения процессов
    lock = multiprocessing.Lock()   # Блокировка для синхронизации доступа к общим ресурсам

    def collect(self):
        """
        Метод собирает результаты выполнения процессов из очереди results.
        
        :return: bool - True, если результат успешно собран, иначе False
        """
        try:
            # Попытка извлечь результат из очереди результатов
            result = self.results.get(block=False)
            # Добавляем полученный результат в хранилище
            self.storage.append(result)
            return True
        except Exception:
            # Если очередь пуста или произошла ошибка
            return False

    def start(self):
        """
        Запускает процессы обработки.
        Создает необходимое количество процессов и запускает их выполнение.
        После запуска ожидает завершения всех процессов и сбор результата.
        """
        self.queue = multiprocessing.Queue()      # Очередь заданий
        self.results = multiprocessing.Queue()    # Очередь результатов
        
        # Устанавливаем количество процессов равное количеству ядер процессора,
        # если оно не задано явно
        if not self.PROC_COUNT:
            self.PROC_COUNT = multiprocessing.cpu_count()
        
        # Создание и запуск необходимого количества процессов
        for _ in range(self.PROC_COUNT):
            process = multiprocessing.Process(
                target=multiprocessing_single_run,  # Функция, выполняемая процессом
                args=(self.queue, self.results, self.lock))  # Аргументы для процесса
            self.processes.append(process)
            process.start()
        
        # Ожидаем завершения всех процессов и собираем результаты
        while len(self.storage) != len(self.processes):
            for i in range(len(self.processes)):
                if self.processes[i] is None:
                    continue
                # Если удалось собрать результат, помечаем процесс как завершённый
                if self.collect():
                    self.processes[i] = None
    
    def get_best(self):
        """
        Возвращает лучший результат среди полученных.
        Сортирует список хранимых результатов и выводит наилучший вариант.
        """
        # Сортируем результаты по первому элементу каждого кортежа
        best = sorted(self.storage, key=lambda x: x[0])
        # Выводим наилучший результат и соответствующие параметры
        print(f"Лучший: {best[-1][0]} с параметрами {best[-1][1]}")



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
        #print(f"[{self.gid}][MUT] Mutation happed to {self.eid} new package: {self.package}") # Выводим запись в консол


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
    STOP = 10 # Максимальное количество итераций 
    P_fill = 0.4 # Вероятность вставить предмет в рюкзак
    P_del = 0.5 # Вероятность удалить предмет из рюкзака
    P_born = 0.6 # Вероятность дать потомство
    P_mut = 0.4 # Вероятность мутации
    OPT_MAX = 50 # Количество поколений без изменений до остановки алгоритма
    ELITE_PERCENT = 0.2 # Процент элиты при делении поколений
    MIGRANT_COUNT = 20
    DISABLE_GENERATION_PRINTER = 1


    def GetGenBest(self):
        return self.population[0] # Получаем лучшее решение в отсортированном массиве особей
    
    def __init__(self,N=100,STOP=10,P_fill=0.4,P_del=0.5,P_born=0.6,P_mut=0.4,OPT_MAX=50,ELITE_PERCENT=0.2):
        global ENABLE_MULTIPROCESSING

        self.population = [] # Массив особей поколения 
        self.eid = 0 # Текущий ID особ/и
        self.gid = 1 # Номер текущего поколения
        self.best = None # Текущее лучшее решение


    def GenerateFirst(self):
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
    
    def NewGen(self, migrant_queue=None):
        global ENABLE_MULTIPROCESSING
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
        if ENABLE_MULTIPROCESSING:

            new_gen = self.population[:self.N-self.MIGRANT_COUNT] # Набираем новое поколение с учетом места для мигрантов
            to_send = self.population[self.N-self.MIGRANT_COUNT:self.N] # берем худших из лучших на отправку в другой процесс
            migrant_queue.put(to_send,timeout=3) # отправляем
            migrants = migrant_queue.get(timeout=5) # забираем
            new_gen +=migrants # добавляем к новому поколению
        else:
            new_gen = self.population[:self.N]
        self.gid += 1  # По завершении генерации увеличиваем номер поколения
        new_gen = qsort(new_gen)  # сортируем результат
        self.population = new_gen  # делаем новое поколение основным
        best = self.GetGenBest()  # получаем лучший результат

        if not self.DISABLE_GENERATION_PRINTER:
            print(
                f"[{self.gid}][INFO] Generaton Created: Score: {best.Score()} Load: {best.package}")  # Выводим лучшую особь из поколения
        return best  # Возвращаем его из функции


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
    print("Thread Ended")
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
    return results
def plot_parameter_influence(results):
    """
    Функция для построения графиков зависимости среднего счета от параметров.
    
    Аргумент:
    - results: Список словарей формата {'score': ..., 'params': {...}}
              Где 'score' — оценка, 'params' — словарь с гиперпараметрами.
    """
    # Преобразуем результаты в DataFrame
    df_results = pd.DataFrame([{'score': res['score']} | res['params'] for res in results])

    # Извлекаем имена параметров
    parameter_names = [col for col in df_results.columns if col != 'score']

    # Рисуем графики для каждого параметра
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
    """
    Функция для построения тепловых карт по парам параметров.
    
    Аргумент:
    - results: Список словарей формата {'score': ..., 'params': {...}}
              Где 'score' — оценка, 'params' — словарь с гиперпараметрами.
    """
    # Преобразуем результаты в DataFrame
    df_results = pd.DataFrame([{'score': res['score']} | res['params'] for res in results])

    # Извлекаем имена параметров
    parameter_names = [col for col in df_results.columns if col != 'score']

    # Формируем пары параметров
    from itertools import combinations
    pairs = list(combinations(parameter_names, 2))

    # Строим тепловые карты для каждой пары параметров
    for pair in pairs:
        pivot_table = df_results.pivot_table(index=pair[0], columns=pair[1], values='score', aggfunc='mean')
        plt.figure(figsize=(10, 8))
        sns.heatmap(pivot_table, annot=True, cmap="YlGnBu", fmt=".2f", linewidths=.5)
        plt.title(f'Tепловая карта: {pair[0]} vs {pair[1]}')
        plt.show()


def multiprocessing_single_run(migrant_queue,result_pipe,lock):
    result = main(migrant_queue) # запускаем алгоритм
    result_pipe.put(result) # возвращаем результат


@timer
def main(migrant_queue = []):
    """
    Основная функция программы
    """
    factory = GenerationFactory()
    factory.GenerateFirst() # Создаем генератор поколений и первое поколение
    old = factory.best # Записываем результат текущего поколения
    OPT_MAX = factory.OPT_MAX
    opt = 0
    while True: # Бесконечный цикл
        try:
            new = factory.NewGen(migrant_queue) # Пытаемся создать новое поколение и записываем лучшего из него
        except StabilizationNotReached:
            print(f"Best: {new.Score()} With solution: {new.package}") # Обрабатывсаем верхнюю границу количества поколений 
            return (new.Score(),new.package)


        if old >= new: # Если текущий не хуже нового прерываемся,стабилизация достигнута 
            opt +=1
            print(f"[STAB] current optimum {opt}")
            if opt >= OPT_MAX:
                print(f"[{factory.gid}][END] Stabilization Reached") # Выводим запись в консоль
                print(f"Best: {old.Score()} With solution: {old.package}")# Выводим полученное решение
                return (old.Score(),new.package) # выходим из программы
        else:
            old = new # Если на этом поколении решения не нашлось, то делаем новое поколение текущим.
            opt = 0
            #print(f"[STAB] current optimum reset {opt}")

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
        results = parallel_grid_search(param_grid,30,375)
        best_result =sorted(results, key=lambda r: r['score'])[0]
        print(best_result)
        plot_parameter_influence(results)
        plot_heatmaps_by_pairs(results)
    elif ENABLE_MULTIPROCESSING:
        manager = ProcManager() # Создаем менеджер процессов
        manager.start() # Запускаем работу алгоритма
        manager.get_best() # получаем лучший результат

    else:
        main() # Точка входа в программу

