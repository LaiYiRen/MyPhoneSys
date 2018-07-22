using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//引用
using System.Data.SqlClient;
using System.Data;
using DBUtility;
using Models;

namespace DAL
{
    //用户服务类
    public class Users_DAL
    {
        /// <summary>
        /// 1、用户登陆
        /// </summary>
        /// <param name="UName"></param>
        /// <returns></returns>
        public Users_Model Users_Login(string UName)
        {
            Users_Model obj = null;
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]
            {
                new SqlParameter("@UName",UName)
            };
            using (SqlDataReader dr = SqlHelper.ExecuteReader("Users_Login", ter))
            {
                if (dr.Read())//如果没有从数据库中读取数据那么说明该用户不存在
                {
                    obj = new Users_Model()
                    {
                        UserID = (int)dr["UserID"],//用户ID
                        UName = dr["UName"].ToString(),//用户唯一标识
                        Pwd = dr["Pwd"].ToString(),//密 码
                        RegisTime = dr["RegisTime"].ToString(),//注册时间
                        LastTime = dr["LastTime"].ToString(),//最后一次登陆时间
                        IsVaild = (bool)dr["IsVaild"],//是否有效
                    };
                }
            }
            return obj;
        }
        /// <summary>
        ///  检验用户是否存在
        /// </summary>
        /// <param name="UName"></param>
        /// <returns></returns>
        public Users_Model Users_Login2(string UName)
        {
            Users_Model obj = null;
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]
            {
                new SqlParameter("@UName",UName)
            };
            using (SqlDataReader dr = SqlHelper.ExecuteReader("Users_Login", ter))
            {
                if (dr.Read())//如果没有从数据库中读取数据那么说明该用户不存在
                {
                    obj = new Users_Model();
                }
            }
            return obj;
        }
        /// <summary>
        /// 2、用户注册
        /// </summary>
        /// <param name="us"></param>
        /// <returns></returns>
        public bool Users_Register(Users_Model us)
        {
            if (Users_Login2(us.UName) != null)
            {
                return false;//用户已经存在
            }
            //采用数组存储参数
            SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@UserName",us.UName),
                    new SqlParameter("@Pwd",us.Pwd)
                };
            return SqlHelper.ExecuteNonQuery("Users_Register", param);
        }
        /// <summary>
        /// 3、查询当前用户基本资料
        /// </summary>
        /// <param name="UName"></param>
        /// <returns></returns>
        public Users_Model Users_UserInfo_ById(string UName)
        {
            Users_Model obj = null;
            //采用数组存储参数
            SqlParameter[] ter = new SqlParameter[]
            {
                new SqlParameter("@UName",UName)
            };
            using (SqlDataReader dr = SqlHelper.ExecuteReader("Users_UserInfo_ById", ter))
            {
                if (dr.Read())//如果没有从数据库中读取数据那么说明该用户不存在
                {
                    obj = new Users_Model();
                    obj.UserID = (int)dr["UserID"];//用户ID
                    if (string.IsNullOrEmpty(dr["UName"].ToString())|| dr["UName"].ToString()=="")obj.UName = "未填写…………";else obj.UName = dr["UName"].ToString();//用户名
                    if (string.IsNullOrEmpty(dr["Phone"].ToString()) || dr["Phone"].ToString() == "") obj.Phone = "未填写…………"; else obj.Phone = dr["Phone"].ToString();//联系电话
                    if (string.IsNullOrEmpty(dr["Email"].ToString()) || dr["Email"].ToString() == "") obj.Email = "未填写…………"; else obj.Email = dr["Email"].ToString();//邮箱
                    if (string.IsNullOrEmpty(dr["Sex"].ToString()) || dr["Sex"].ToString() == "") obj.Sex = "未填写…………"; else obj.Sex = dr["Sex"].ToString();//性别
                    if (string.IsNullOrEmpty(dr["Birthday"].ToString()) || dr["Birthday"].ToString() == "") obj.Birthday = "未填写…………"; else obj.Birthday = dr["Birthday"].ToString();//生日
                    if (string.IsNullOrEmpty(dr["QQ"].ToString()) || dr["QQ"].ToString() == "") obj.QQ = "未填写…………"; else obj.QQ = dr["QQ"].ToString();//QQ
                    if (string.IsNullOrEmpty(dr["WeiXin"].ToString()) || dr["WeiXin"].ToString() == "") obj.WeiXin = "未填写…………"; else obj.WeiXin = dr["WeiXin"].ToString();//微信
                    if (string.IsNullOrEmpty(dr["ShenFenZheng"].ToString()) || dr["ShenFenZheng"].ToString() == "") obj.ShenFenZheng = "未填写…………"; else obj.ShenFenZheng = dr["ShenFenZheng"].ToString();//身份证
                    if (string.IsNullOrEmpty(dr["Address"].ToString()) || dr["Address"].ToString() == "") obj.Address = "未填写…………"; else obj.Address = dr["Address"].ToString();//居住地
                    if (string.IsNullOrEmpty(dr["RegisTime"].ToString()) || dr["RegisTime"].ToString() == "") obj.RegisTime = "未填写…………"; else  obj.RegisTime = Convert.ToDateTime(dr["RegisTime"]).ToString("yyyy-MM-dd-hh-mm-ss");//注册时间   
                }
            }
            return obj;
        }
    }
}
