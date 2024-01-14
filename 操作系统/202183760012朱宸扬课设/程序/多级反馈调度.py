import pygame
import random
import time
from queue import Queue
import threading

# 初始化 Pygame
pygame.init()

# 设置屏幕大小和颜色
WIDTH, HEIGHT = 800, 600
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Multi-Level Feedback Queue Scheduling")

# 定义进程类
class Process:
    def __init__(self, name, job_size):
        self.name = name
        self.job_size = job_size
        self.color = (random.randint(210, 255), random.randint(210, 255), random.randint(210, 255))


# 创建四个队列，时间片分别为1、2、4、8
queues = [Queue() for _ in range(4)]
time_slices = [1, 2, 4, 8]

# 创建停止标志
stop_flag = threading.Event()

# 创建互斥锁
lock = threading.Lock()

# 创建队列和进程的初始坐标
queue_coordinates = [(50, 200), (250, 200), (450, 200), (650, 200)]
process_coordinates = (50, 400)

# 创建进程和队列的字体
font = pygame.font.Font(None, 36)

# 创建 Pygame 时钟对象
clock = pygame.time.Clock()
def draw_queues_and_processes():
    screen.fill(WHITE)

    # Display the title
    title_text = font.render("Multi-Level Feedback Queue Scheduling", True, BLACK)
    screen.blit(title_text, (WIDTH // 2 - 250, 50))

    # 绘制队列
    for i, q in enumerate(queues):
        pygame.draw.rect(screen, BLACK, (queue_coordinates[i][0], queue_coordinates[i][1], 50, 250), 2)  # Slight increase in height to 250

        # 绘制 Queue 文本
        text_queue = font.render(f"Queue {i + 1}", True, BLACK)
        screen.blit(text_queue, (queue_coordinates[i][0] + 10, queue_coordinates[i][1] + 270))  # Below Queue

        # 绘制进程在队列中的位置
        for j, process in enumerate(q.queue):
            pygame.draw.rect(screen, process.color, (queue_coordinates[i][0], queue_coordinates[i][1] + j * 40, 50, 30))  # Slight decrease in spacing to 30
            # 显示剩余的 job_size
            text = font.render(str(process.job_size), True, BLACK)
            screen.blit(text, (queue_coordinates[i][0] + 10, queue_coordinates[i][1] + j * 40 + 5))

        # 绘制 Time Slice 文本
        text_time_slice = font.render(f"Time Slice {2**i}", True, BLACK)
        screen.blit(text_time_slice, (queue_coordinates[i][0] + 10, queue_coordinates[i][1] - 30))  # Above Queue

    pygame.display.flip()










def working():
    while not stop_flag.is_set() or any(not queue.empty() for queue in queues):
        for i in range(len(queues)):
            queue_size = queues[i].qsize()  # Get the number of elements in the queue
            for _ in range(queue_size):
                with lock:
                    process = queues[i].get()
                    temp = process.job_size
                    process.job_size -= time_slices[i]

                if process.job_size < 0:
                    time.sleep(temp/4)
                    process.job_size = 0
                else:
                    time.sleep(time_slices[i]/4)

                with lock:
                    if process.job_size > 0:
                        if i == 3:
                            queues[3].put(process)
                        else:
                            queues[i + 1].put(process)
                    else:
                        print(f"{process.name} 运行结束")

                draw_queues_and_processes()
                clock.tick(10)  # 控制帧率



def create_processes():
    process_num = 1
    while not stop_flag.is_set() and process_num <= 15:  # 创建五个新进程后停止
        with lock:
            new_process = Process(f"Process-{process_num}", random.randint(1, 30))
            queues[0].put(new_process)
            print(f"New process created: {new_process.name} (Job Size: {new_process.job_size})")
        process_num += 1
        time.sleep(random.uniform(1, 3))  # 随机间隔时间

    # 设置停止标志
    stop_flag.set()

# 创建两个线程
working_thread = threading.Thread(target=working)
create_processes_thread = threading.Thread(target=create_processes)

# 启动线程
working_thread.start()
create_processes_thread.start()

# 运行 Pygame 主循环
running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

# 等待两个线程完成
working_thread.join()
create_processes_thread.join()

# 退出 Pygame
pygame.quit()
