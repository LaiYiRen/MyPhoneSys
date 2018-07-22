using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace DBUtility
{
    /// <summary>
    /// 抽象连接操作类
    /// </summary>
    public abstract class SqlHelper
    {
        /// <summary>
        /// 从web.config中获取连接字符串
        /// </summary>
        public static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectString"].ConnectionString;
        /// <summary>
        /// 通过连接字符串，获取连接，执行SQL语句（添加，修改，删除）
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="commandType">执行类型（文本、存储过程）</param>
        /// <param name="commandText">执行文本（执行语句、存储过程名称)</param>
        /// <param name="commandParameters">参数数组</param>
        /// <returns>返回影响行数（文本执行有返回值，存储过程返回0)</returns>
        public static bool ExecuteNonQuery(CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand cmd = new SqlCommand();//实例化命令对象
            SqlConnection conn = new SqlConnection(ConnectionString);//实例化连接对象
            bool b = false;
            try
            {
                PrepareCommand(cmd, conn,cmdType, cmdText, commandParameters);//调用公共方法
                cmd.ExecuteNonQuery();//执行命令
                cmd.Parameters.Clear();//清除参数
                b = true;
            }
            catch
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return b;
        }
        /// <summary>
        /// 通过连接字符串，获取连接，执行SQL语句（添加，修改，删除）
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="commandType">执行类型（文本、存储过程）</param>
        /// <param name="commandText">执行文本（执行语句、存储过程名称)</param>
        /// <param name="commandParameters">参数数组</param>
        /// <returns>返回影响行数（文本执行有返回值，存储过程返回0)</returns>
        public static bool ExecuteNonQuery(string cmdText, params SqlParameter[] commandParameters)
        {
            bool b = false;
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(ConnectionString);
            try
            {
                PrepareCommand(cmd, conn, CommandType.StoredProcedure, cmdText, commandParameters);//调用公共方法
                cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();//清除参数
                b = true; ;
            }
            catch
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return b;
        }
        /// <summary>
        /// 通过SqlDataReader获取数据,读取完后关闭连接
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="commandType">执行类型（文本、存储过程）</param>
        /// <param name="commandText">执行文本（执行语句、存储过程名称)</param>
        /// <param name="commandParameters">参数数组</param>
        /// <returns>返回影响行数（文本执行有返回值，存储过程返回0)</returns>
        public static SqlDataReader ExecuteReader(CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(ConnectionString);
            try
            {
                PrepareCommand(cmd, conn, cmdType, cmdText, commandParameters);//调用公共方法
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();//清除参数
                return rdr;
            }
            catch
            {
                conn.Close();
                throw;
            }
        }
        /// <summary>
        /// 通过SqlDataReader获取数据,读取完后关闭连接
        /// </summary>
        /// <param name="commandText">执行文本（执行语句、存储过程名称)</param>
        /// <param name="commandParameters">参数数组</param>
        /// <returns>返回影响行数（文本执行有返回值，存储过程返回0)</returns>
        public static SqlDataReader ExecuteReader(string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(ConnectionString);
            try
            {
                PrepareCommand(cmd, conn, CommandType.StoredProcedure, cmdText, commandParameters);//调用公共方法
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();//清除参数
                return rdr;
            }
            catch
            {
                conn.Close();
                throw;
            }
        }
        /// <summary>
        /// 获取第一行第一列的数据
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="commandType">执行类型（文本、存储过程）</param>
        /// <param name="commandText">执行文本（执行语句、存储过程名称)</param>
        /// <param name="commandParameters">参数数组</param>
        /// <returns>返回影响行数（文本执行有返回值，存储过程返回0)</returns>
        public static object ExecuteScalar(CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection connection = new SqlConnection(ConnectionString);
            try
            {
                PrepareCommand(cmd, connection, cmdType, cmdText, commandParameters);//调用公共方法
                object val = cmd.ExecuteScalar();
                cmd.Parameters.Clear();//清除参数
                return val;
            }
            catch
            {
                throw;
            }
            finally
            {
                connection.Close();
            } 
        }
        /// <summary>
        /// 获取第一行第一列的数据
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="commandType">执行类型（文本、存储过程）</param>
        /// <param name="commandText">执行文本（执行语句、存储过程名称)</param>
        /// <param name="commandParameters">参数数组</param>
        /// <returns>返回影响行数（文本执行有返回值，存储过程返回0)</returns>
        public static object ExecuteScalar(string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection connection = new SqlConnection(ConnectionString);
            try
            {
                PrepareCommand(cmd, connection, CommandType.StoredProcedure, cmdText, commandParameters);//调用公共方法
                object val = cmd.ExecuteScalar();
                cmd.Parameters.Clear();//清除参数
                return val;
            }
            catch
            {
                throw;
            }
            finally
            {
                connection.Close();
            }
        }
        /// <summary>
        /// 共用类，连接打开，添加事务、添加参数列表
        /// </summary>
        /// <param name="cmd">Sql命令</param>
        /// <param name="conn">数据库连接对象</param>
        /// <param name="trans">事务</param>
        /// <param name="cmdType">执行类型（文本、存储过程）</param>
        /// <param name="cmdText">执行文本（执行语句、存储过程名称)</param>
        /// <param name="cmdParms">参数数组</param>
        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, CommandType cmdType, string cmdText, SqlParameter[] param)
        {
            if (conn.State != ConnectionState.Open)//判断连接是否打开
                conn.Open();//打开连接
            cmd.Connection = conn;//设置连接对象
            cmd.CommandText = cmdText;//设置命令文本
            cmd.CommandType = cmdType;//设置命令类型
            if (param != null)//判断参数是否为空
                    cmd.Parameters.AddRange(param);//添加数组
        }
        /// <summary>
        /// 返回DataSet
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="commandParameters"></param>
        /// <returns></returns>
        public static DataSet GetDataSet(CommandType cmdType,string cmdText, params SqlParameter[] param)
        {
            DataSet ds = new DataSet();//实例化数据集
            SqlConnection dsConn = new SqlConnection(ConnectionString);//实例化连接对象
            SqlCommand cmd = new SqlCommand(cmdText, dsConn);//实例化命令对象
            cmd.CommandType = cmdType;//设置类型
            if (param != null)
                cmd.Parameters.AddRange(param);
            SqlDataAdapter ada = new SqlDataAdapter(cmd);
            ada.Fill(ds);

            return ds;
        }
    }
}