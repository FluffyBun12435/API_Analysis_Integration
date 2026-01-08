from sqlalchemy import create_engine

class DBHandler:
    def __init__(self, host, user, password, database):
        """
        初始化连接
        """
        self.connection_string = f'mysql+mysqlconnector://{user}:{password}@{host}/{database}'
        self.engine = create_engine(self.connection_string)

    def save_dataframe(self, df, table_name):
        """
        负责把一个 DataFrame 表格直接塞进 MySQL
        """
        try:
            print(f"正在尝试将数据存入表: {table_name}...")
            df.to_sql(name=table_name, con=self.engine, if_exists='replace', index=False)
            print(f"✅ 成功！数据已存入数据库。")
        except Exception as e:
            print(f"❌ 存储失败，错误信息: {e}")