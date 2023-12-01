import threading
import time
import random

mutex = threading.Semaphore(1)
full_empty = threading.Lock()
not_full = threading.Condition(full_empty)
no_apple = threading.Condition(full_empty)
no_orange = threading.Condition(full_empty)

list = []
global count
count=0
def father():
    global count
    while(1):
        with not_full:
            while list and list[0] is not None:
                print("盘子满了，父亲阻塞")
                not_full.wait()
            mutex.acquire()
            print("父亲放苹果")
            list.append("苹果")
            print(list)
            count+=1
            time.sleep(random.randint(1,2))
            no_apple.notify()
            mutex.release()
        time.sleep(random.randint(1,2))

def mother():
    global count
    while(1):
        with not_full:
            while list and list[0] is not None:
                print("盘子满了，母亲阻塞")
                not_full.wait()
            mutex.acquire()
            print("母亲放橘子")
            list.append("橘子")
            print(list)
            count+=1
            time.sleep(random.randint(1,2))
            no_orange.notify()
            mutex.release()
        time.sleep(random.randint(1,2))


def son():
    global count
    while(1):
        with no_apple:
            while list==[] or (list[0] is None or list[0] != '苹果'):
                print("盘子无苹果，儿子阻塞")
                no_apple.wait()
            print("儿子吃苹果")
            list.pop()
            print(list)

            time.sleep(random.randint(1,2))
            not_full.notify()
        time.sleep(random.randint(1,2))

def daughter():
    global count
    while(1):
        with no_orange:
            while list==[] or (list[0] is None or list[0] != '橘子'):
                print("盘子无橘子，女儿阻塞")
                no_orange.wait()
            print("女儿吃橘子")
            list.pop()
            print(list)

            time.sleep(random.randint(1,2))
            not_full.notify()
        time.sleep(random.randint(1,2))

if __name__ == '__main__':

    # 创建两个生产者线程和两个消费者线程
    father = threading.Thread(target=father)
    mother = threading.Thread(target=mother)
    son = threading.Thread(target=son)
    daughter = threading.Thread(target=daughter)
    # 启动所有线程
    father.start()
    mother.start()
    son.start()
    daughter.start()




