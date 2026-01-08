from scripts.api_handler import fetch_repos  # 从 api 文件导入函数
from scripts.db_handler import DBHandler    # 从 db 文件导入函数
import pandas as pd

# 1. 抓取数据（API 逻辑）
df = fetch_repos("FluffyBun12435")
print(df)


# 2. 存储数据（DB 逻辑）
if df is not None:
    # 填入你之前的本地数据库密码
    db = DBHandler(host='localhost', user='root', password='****', database='gastro_analysis')
    db.save_dataframe(df, 'my_github_repos')

# 在 main.py 最底部添加，用于验证

# 还是用你那个存储员的 engine
query = "SELECT * FROM my_github_repos" # 这里的名字要和 save_to_mysql 里的 table_name 一致
verified_df = pd.read_sql(query, db.engine) 

print("\n--- 正在从 MySQL 数据库读取存入的数据进行验证 ---")
print(verified_df.head()) # 打印前几行
print(f"\n验证完毕: 数据库中共有 {len(verified_df)} 条仓库记录。")