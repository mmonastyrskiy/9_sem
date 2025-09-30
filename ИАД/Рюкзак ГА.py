
from random import random,seed,choice
from time import time,perf_counter
from math import floor

seed(time()) # инициализация ГПСЧ

def roulette(P: float):
    return random() < P # Реализация функции активации на основе ГПСЧ


# Выключатели тестов


# константы 
"""
SAMPLES = [
    {"c": 18, "w": 20, "m": 1},
    {"c": 30, "w": 40, "m": 1},
    {"c": 25, "w": 50, "m": 1},
    {"c": 15, "w": 10, "m": 1},
    {"c": 40, "w": 60, "m": 1},
    {"c": 20, "w": 30, "m": 1},
    {"c": 35, "w": 55, "m": 1},
    {"c": 10, "w": 5, "m": 1},
    {"c": 45, "w": 70, "m": 1},
    {"c": 22, "w": 25, "m": 1}
]
"""

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

N = 10000 # Количество особей
S = 250 # вместимость рюкзака
STOP = 200 # Максимальное количество итераций 
P_fill = 0.4 # Вероятность вставить предмет в рюкзак
P_del = 0.5 # Вероятность удалить предмет из рюкзака
P_born = 0.6 # Вероятность дать потомство
P_mut = 0.4 # Вероятность мутации
OPT_MAX = 50


def timer(func):
    def wrapper(*args, **kwargs):
        start_time = perf_counter()
        result = func(*args,**kwargs)
        end_time = perf_counter()
        exec_time = end_time - start_time
        print(f"Function '{func.__name__}' executed in {exec_time:.4f} seconds.")
        return result
    return wrapper



class StabilizationNotReached(Exception):
    """
    Определение исключения для отлова момента прекращения алгоритма при превышении количества итераций
    """
    pass



class Entity(): # Класс - особь
    package = [] # Решение для текущей особи

    def __init__(self,package=[],eid=0,gid=0): # Конструктор класса
        """
        Реализует два варианта создания сущностей
        с пустым рюкзаком - первое поколение
        с заранее готовым вектором, при наследовании решения от родителей
        """
        global SAMPLES
        global S
        self.eid = eid # ID Сущности
        self.gid =gid # Номер поколения
        eid +=1
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
        global P_fill
        global SAMPLES
        while self.HasSpace(): # Пока можем положить что-то еще в рюкзак
            for i in range(len(self.package)): # Итерируемся по рюкзаку 
                if roulette(P_fill) and self.S >= SAMPLES[i]["w"]: # Если объект нужно положить и он помещается
                    self.package[i]+=1 #Увеличиваем кол-во
                    self.S -= SAMPLES[i]["w"] # Пересчитываем вес
                    #print(f"[{self.gid}][LOAD] Object {i} is loaded into entity {self.eid} currennt load = {self.package}") # Выводим запись в консоль
                    if not self._check():
                        self.refill()
    def Mutate(self):
        """
        Функция мутации 
        """
        global P_mut
        global P_del
        global SAMPLES
        if roulette(P_mut): # Если нужно мутировать
            StateChanged = False #Флаг для гарантии внесения изменений в рюкзак
            old_package = self.package
            while not StateChanged: # Пока рюкзак не изменится 
                for i in range(len(self.package)): # Ходим по рюкзаку
                    if roulette(P_del): # Пробуем вытащить каждый из элментов 
                        self.package[i] -=1 # Если вытащился, уменьшаем кол-во элементов
                        self.S += SAMPLES[i]['w'] # Пересчитываем пустой вес
                        StateChanged = True # Устанавливаем флаг изменения состояния 
        self.Fill() # Перезаполняем рюкзак
        if not self._check():
            self.package = old_package
        #print(f"[{self.gid}][MUT] Mutation happed to {self.eid} new package: {self.package}") # Выводим запись в консоль



    def HaveBaby(self,parent,childid):
        """
        Функция "Деторождения"
        parent - второй родитель
        childid - ID присваеваемый ребенку
        """
        global P_born
        global SAMPLES
        if not roulette(P_born):
            #print(f"[{self.gid}][BORN]No baby =( ")
            return None # Если детей не будет, выходим из функции 
        
        r = [self.package[i] if self.package[i]== parent.package[i] else SAMPLES[i]["m"] for i in range(len(self.package))] # Создаем наследованное решение, общие значения родителей сохраняем, в противном случае ставим минимум
        child = Entity(package=r,eid=childid,gid=self.gid+1) # Создаем особь с созданным решением
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


    def GetGenBest(self):
        return self.population[0] # Получаем лучшее решение в отсортированном массиве особей
    
    def __init__(self):
        global N
        self.population = [] # Массив особей поколения 
        self.eid = 0 # Текущий ID особ/и
        self.gid = 1 # Номер текущего поколения
        self.best = None # Текущее лучшее решение
        while len(self.population) < N: # Пока в поколении не хватает особей создаем новые
            self.population.append(Entity(eid=self.eid,gid=self.gid))
            self.eid +=1
        self.population = qsort(self.population) # Сортируем особей в поколении по убыванию конечной стоимости
        self.best = self.GetGenBest() # Получаем лучшее решение и сохраняем
        self.gid +=1 # Увеличиваем номер поколения 


    
    def SplitPopulation(self): # Разбиваем поколение в соотношении 20/80 с округлением в меньшую сторону
        global N
        p20 = floor(N*0.2) # вычисляем индекс разбиения
        best = self.population[:p20] # Первые 20%
        worst = self.population[p20:] # прочее
        return (best,worst)
    
    def NewGen(self):
        """
        Функция генерации нового поколенiidия 
        """
        global STOP
        global N
        print(f"Новое поколение {self.gid}")
        if self.gid > STOP: # Если номер поколения превышает максимум прерываемся с сообщением в консоль
            raise StabilizationNotReached("[END] Stabilization not reached stopping due to limitation of itterations ")


        best, worst = self.SplitPopulation()  # Разбиваем текущее поколение на лучших и худших
        while len(self.population) < N*2:
            p1 = choice(best)  # Случайный родитель из лучших
            p2 = choice(worst)  # случайный родитель из худших
            #print(f"Пытаемся родить: Выбранные родители {p1.eid}  {p2.eid} ")
            c = p1.HaveBaby(p2, self.eid)  # Пытаемся родить потомка
            if c is None:  # Если не родился перезапускаем цикл, ищем новых родителей
                continue
            self.eid += 1  # В противном случае увеличиваем текущий индекс ребенка
            self.population.append(c)  # Записываем ребенка в новое поколение
        self.population = qsort(self.population)
        new_gen = self.population[:N]
        self.gid += 1  # По завершении генерации увеличиваем номер поколения
        new_gen = qsort(new_gen)  # сортируем результат
        self.population = new_gen  # делаем новое поколение основным
        best = self.GetGenBest()  # получаем лучший результат
        print(
            f"[{self.gid}][INFO] Generaton Created: Score: {best.Score()} Load: {best.package}")  # Выводим лучшую особь из поколения
        return best  # Возвращаем его из функции
@timer
def main():
    """
    Основная функция программы
    """
    factory = GenerationFactory() # Создаем генератор поколений и первое поколение
    old = factory.best # Записываем результат текущего поколения
    global OPT_MAX
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
    main() # Точка входа в программу

