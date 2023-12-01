import threading
import time
import random

mutex = threading.Semaphore(1)
full_empty = threading.Lock()
not_full = threading.Condition(full_empty)
not_empty = threading.Condition(full_empty)
global list
list = [0 for x in range(8)]
global count
count = 0
global pindex
pindex = 0
global cindex
cindex = 0


def producer():
    global count,pindex
    ptr = [x for x in range(8)]

    while(1):
        with not_full:
            while count==8:
                print("资源池满了，生产者阻塞")
                not_full.wait()
            mutex.acquire()
            item = 1
            list[pindex] = item
            print(list)
            pindex = 0 if pindex == 7 else pindex+1
            count+=1
            # time.sleep(random.randint(1,3))
            not_empty.notify()
            mutex.release()
        time.sleep(random.randint(1,3))


def consumer():
    global count,cindex
    ctr = [x for x in range(8)]
    while(1):
        with not_empty:
            while count==0:
                print("资源池空了，消费者阻塞")
                not_empty.wait()
            mutex.acquire()
            item = 0
            list[cindex] = item
            print(list)
            cindex = 0 if cindex == 7 else cindex+1
            count -= 1
            # time.sleep(random.randint(1,3))
            not_full.notify()
            mutex.release()
        time.sleep(random.randint(1,3))



if __name__ == '__main__':

    # 创建两个生产者线程和两个消费者线程
    producers = [threading.Thread(target=producer) for _ in range(100)]
    consumers = [threading.Thread(target=consumer) for _ in range(100)]

    # 启动所有线程
    for _ in range(100):
        producers[_].start()

    for _ in range(100):
        consumers[_].start()


