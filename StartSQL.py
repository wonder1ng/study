import pymysql
import pandas as pd

class StartSQL:
    def __init__(self, user, password, database, host='localhost', charset='utf8mb4', port=3306,) -> None:
        self.user = user
        self.database = database
        self.host = host
        self.connect = pymysql.connect(host=host,
                      port=port,
                      user=user,
                      password=password,
                      database=database,
                      charset=charset)
        self.cur = self.connect.cursor()
    
    def create_table(self, table:str, cols:str):
        try:
            self.cur.execute(f'create table {table}({cols})')
            return True
        except: return False
    
    def select_table(self, table):
        self.table = table
        self.cols = tuple([self.cur.execute(f'desc {self.table}'), pd.DataFrame(self.cur.fetchall())][1][0])

    def desc(self, table_name=None):
        return [self.cur.execute(f'desc {self.table}'), pd.DataFrame(self.cur.fetchall())][1] if table_name==None else [self.cur.execute(f'desc {table_name}'), pd.DataFrame(self.cur.fetchall())][1]

    def insert(self, values:str, cols:str=None):
        if cols==None: cols = self.cols
        cols = ",".join(cols)
        try:
            self.cur.execute(f'insert into {self.table} ({cols}) values({values})')
            self.connect.commit()
            return True
        except Exception as e: print(e); return False
    
    def insert_many(self, values:list, cols:list=None):
        if cols==None: cols = self.cols
        cols = ",".join(cols)
        try:
            for i in values:
                self.cur.execute(f'insert into {self.table} ({cols}) values({i})')
            self.connect.commit()
            return True
        except Exception as e: print(e); return False
    
    def select(self, columns='*', rows=None, table=None):
        if table==None: table=self.table
        if rows==None: 
            self.cur.execute(f'select {columns} from {table}')
            return pd.DataFrame(self.cur.fetchall())
        else:
            self.cur.execute(f'select {columns} from {table}')
            return pd.DataFrame(self.cur.fetchall()).iloc[:rows]
        
    def update(self, setV, setC, whereV, whereC='id', table=None):
        if table==None: table=self.table
        if type(setV)==str: setV = f'\"{setV}\"'
        if type(whereV)==str: whereV = f'\"{whereV}\"'
        self.cur.execute(f'update {table} set {setC}={setV} where {whereC}={whereV}')
        self.connect.commit()

    def delete(self, whereV, whereC='id', table=None):
        if table==None: table=self.table
        if type(whereV)==str: whereV = f'\"{whereV}\"'
        self.cur.execute(f'delete from {table} where {whereC}={whereV}')
        self.connect.commit()

    def end(self):
        self.cur.execute(f'drop table {self.table}')
        self.connect.close()