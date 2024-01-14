import time
from multiprocessing import Process, Semaphore, Value


def reader(wmutex, rmutex, readcount, id):
    rmutex.acquire()
    readcount.value += 1
    if readcount.value == 1:
        wmutex.acquire()
    rmutex.release()
    print('========Reader %d is reading:==== =====' % id)
    time.sleep(1)
    print('========Reader %d ends reading:==== =====' % id)
    rmutex.acquire()
    readcount.value -= 1
    if readcount.value == 0:
        wmutex.release()
    rmutex.release()


def writer(wmutex, id):
    time.sleep(0.1)
    wmutex.acquire()
    print('========Writer %d is writing:==== =====' % id)
    time.sleep(0.5)
    print('========Writer %d ends writing:==== =====' % id)
    wmutex.release()


if __name__ == '__main__':
    Wmutex = Semaphore(1)
    Rmutex = Semaphore(1)
    readcount = Value('i', 0)

    reader_list = []
    writer_list = []

    for i in range(20):
        p = Process(target=reader, args=(Wmutex, Rmutex, readcount, i))
        time.sleep(0.2)
        reader_list.append(p)
        p.start()

    for j in range(20):
        p = Process(target=writer, args=(Wmutex, j))
        writer_list.append(p)
        p.start()






