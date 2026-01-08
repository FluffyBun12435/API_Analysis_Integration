import requests
import pandas as pd

def fetch_repos(username): 
    url = f"https://api.github.com/users/{username}/repos"
    print(f"--- 正在连接 GitHub API 抓取 {username} 的仓库 ---")
    
    try:
        response = requests.get(url)
        if response.status_code == 200:
            repos = response.json()
            df = pd.DataFrame(repos)
            # 挑选你想要的列
            summary = df[['name', 'id', 'stargazers_count']]
            return summary # 把处理好的表格“交还”给调用它的 main.py
        else:
            print(f"抓取失败: {response.status_code}")
            return None
    except Exception as e:
        print(f"发生错误: {e}")
        return None