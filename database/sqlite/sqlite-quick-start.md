---
sidebar_position: 4
---

# SQLite 快速入门



## 示例程序

```cpp showLineNumbers
#include <iostream>
#include <string.h>
#include "sqlite3.h"

using namespace std;

//创建"表"函数
void Create(int &rc,sqlite3 *db,char *sql,sqlite3_stmt *stmt)
{
	//判断是否已经存在表了
	rc=sqlite3_prepare_v2(db,sql,strlen(sql),&stmt,0);
	if (rc)
	{
		fprintf(stderr,"对象转换失败:%s\n",sqlite3_errmsg(db));
		return;
	}
	//执行stmt(执行SQL语句)
	sqlite3_step(stmt);
	//释放stmt资源
	sqlite3_finalize(stmt);
}

void Insert(int &rc,char *sql,sqlite3 *db,sqlite3_stmt *stmt,char name[])
{
	sprintf(sql,"INSERT INTO MyTable VALUES(NULL,'%s');",name);
	rc=sqlite3_prepare_v2(db,sql,strlen(sql),&stmt,0);
	if (rc)
	{
		fprintf(stderr,"对象转换失败:%s\n",sqlite3_errmsg(db));
		return;
	}
	sqlite3_step(stmt);
	sqlite3_finalize(stmt);
}

int main()
{
	//sqlite3两个重要对象
	sqlite3 *db;
	sqlite3_stmt *stmt=0;
	
	//创建表的结构
	char sql[]=	"CREATE TABLE IF NOT EXISTS MyTable(ID integer NOT NULL primary "
		"key autoincrement,Name nvarchar(32));";
	
	//[1]打开数据库
	int rc=sqlite3_open("MyDB.db",&db);
	if (rc)
	{
		sqlite3_close(db);
		return -1;
	}
	else
		Create(rc,db,sql,stmt);
	
	//向数据里边插入些数据,用来测试
	Insert(rc,sql,db,stmt,"张三");
	Insert(rc,sql,db,stmt,"李四");
	Insert(rc,sql,db,stmt,"王五");
	Insert(rc,sql,db,stmt,"赵六");
	
	sprintf(sql,"SELECT * FROM MyTable;");
	//[2]将SQL语句转换成stmt对象
	sqlite3_prepare_v2(db,sql,strlen(sql),&stmt,0);
	int id;
	unsigned char *name;
	//[3]循环执行stmt对象,读取数据库里边的数据
	while(sqlite3_step(stmt)==SQLITE_ROW)
	{
		//[4]绑定变量
		id=sqlite3_column_int(stmt,0);
		name=(unsigned char *)sqlite3_column_text(stmt,1);
		cout<<id<<'\t'<<name<<endl;
	}
	//[5]释放资源
	sqlite3_finalize(stmt);
	//[6]关闭数据库
	sqlite3_close(db);
	return 0;
}
```


在使用CMake构建 sqlite 项目时，出现 undefined reference to dlopen, dlclose, dlsym and dlerror

```bash
/root/workspace/sqlite_test/sqlite/lib/libsqlite.so: undefined reference to `dlopen'
/root/workspace/sqlite_test/sqlite/lib/libsqlite.so: undefined reference to `dlclose'
/root/workspace/sqlite_test/sqlite/lib/libsqlite.so: undefined reference to `dlerror'
/root/workspace/sqlite_test/sqlite/lib/libsqlite.so: undefined reference to `dlsym'
collect2: error: ld returned 1 exit status
make[2]: *** [main] Error 1
make[1]: *** [CMakeFiles/main.dir/all] Error 2
make: *** [all] Error 2
```

解决办法是加上 `-ldl` 选项链接 dl 库

```bash showLineNumbers
# target_link_libraries 后面把选项 -ldl 添加上即可
add_executable(main ${SRC_MAIN})
target_link_libraries(main sqlite dl)
```



