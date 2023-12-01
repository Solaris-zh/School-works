import random
import time
from queue import Queue

class Process:
    def __init__(self, name, job_size):
        self.name = name
        self.job_size = job_size

# 创建四个队列，时间片分别为1、2、4、8
queues = [Queue() for _ in range(4)]
time_slices = [1, 2, 4, 8]

# 创建十个进程，每个进程具有随机的作业量
processes = [Process(f"Process-{i}", random.randint(1, 50)) for i in range(1, 11)]

# 放入第一个队列（最高优先级队列）
for process in processes:
    print(f"Running {process.name} :(Job Size: {process.job_size})")
    queues[0].put(process)

# 模拟调度器
while not all(queue.empty() for queue in queues):
    for i in range(len(queues)):
        while not queues[i].empty():
            process = queues[i].get()
            temp = process.job_size
            process.job_size -= time_slices[i]


            if(process.job_size<0):
                time.sleep(temp/5)
                process.job_size = 0
            else:
                time.sleep(time_slices[i]/5)
            print(f"Running {process.name} (Time Slice: {time_slices[i]}) (Job Size: {process.job_size})")
            if process.job_size > 0:
                if i == 3:
                    queues[3].put(process)
                else:
                    queues[i + 1].put(process)  # Move the process to the next queue
            else:
                print(f" {process.name} 运行结束")



# (Job Size: {process.job_size})