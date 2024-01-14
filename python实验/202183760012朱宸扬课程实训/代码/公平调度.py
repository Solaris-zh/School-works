import time
from multiprocessing import Process, Semaphore, Value


def reader(rmutex, readcount, id):
    if (readcount.value % 2) == 0:
        rmutex.acquire()
        readcount.value += 1
        print('========Reader %d is reading:==== =====' % id)
        time.sleep(0.5)
        # print('========Reader %d ends reading:==== =====' % id)
        rmutex.release()

    else:
        time.sleep(1)
        reader(rmutex, readcount, id)


def writer(wmutex, readcount, id):
    if (readcount.value % 2) == 1:
        wmutex.acquire()
        readcount.value += 1
        print('========Writer %d is writing:==== =====' % id)
        time.sleep(0.5)
        # print('========Writer %d ends writing:==== =====' % id)
        wmutex.release()

    else:
        time.sleep(1)
        writer(wmutex, readcount,id)


if __name__ == '__main__':
    Wmutex = Semaphore(1)
    Rmutex = Semaphore(1)
    readcount = Value('i', 0)

    reader_list = []
    writer_list = []

    for i in range(10):
        p = Process(target=reader, args=(Rmutex, readcount, i))
        time.sleep(0.2)
        reader_list.append(p)
        p.start()

    for j in range(10):
        p = Process(target=writer, args=(Wmutex, readcount, j))
        writer_list.append(p)
        p.start()

    for i in reader_list:
        i.join()

    for j in writer_list:
        j.join()
