import time

import requests
from lxml import etree
from concurrent.futures import ThreadPoolExecutor
from multiprocessing import *

def fun(url):
    headers = {
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
    }
    response = requests.get(url, headers=headers)
    html = response.content.decode()
    # print(html)
    tree = etree.HTML(html)
    # 解析数据
    # 获取所有应用的li列表
    li_list = tree.xpath('//ul[@class="applist"]/li')
    for li in li_list:
        title = li.xpath('./h5/a/text()')[0]  # 提取标题
        href = li.xpath('./h5/a/@href')[0]  # 提取连接
        print(title, href, url)
        time.sleep(1)

def fun1(url):
    pool = ThreadPoolExecutor(3)
    pool.submit(fun, url)
    pool.shutdown()



if __name__ == '__main__':

    list = []

    for i in range(10):
        url = f'https://app.mi.com/catTopList/0?page={i}'
        p = Process(target=fun1,args=(url,))
        list.append(p)
        p.start()

    for j in list:
        j.join()

    print('over')
