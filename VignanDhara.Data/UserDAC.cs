using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VignanDhara.Entities;

namespace VignanDhara.Data
{
    public class UserDAC
    {
        public bool AuthenticateUser(string conStr, string email, string password)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("spAuthenticateUser", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramEmail = new SqlParameter("email", email);
                SqlParameter paramPassword = new SqlParameter("password", password);

                cmd.Parameters.Add(paramEmail);
                cmd.Parameters.Add(paramPassword);

                con.Open();
                int ReturnCode = (int)cmd.ExecuteScalar();
                return ReturnCode == 1;
            }
        }

        public User GetUserDetails(string conStr, string email)
        {
            User user = null;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("spGetUserDetails", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@email", email);

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            user = new User
                            {
                                UserId = reader["UserId"] != DBNull.Value ? Convert.ToInt32(reader["UserId"]) : 0,
                                UserType = reader["UserType"] != DBNull.Value ? Convert.ToInt32(reader["UserType"]) : 0,
                                FirstName = reader["FirstName"] != DBNull.Value ? reader["FirstName"].ToString() : null,
                                LastName = reader["LastName"] != DBNull.Value ? reader["LastName"].ToString() : null,
                                EmailId = reader["EmailId"] != DBNull.Value ? reader["EmailId"].ToString() : null,
                                Phone = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : null,
                                Password = reader["Password"] != DBNull.Value ? reader["Password"].ToString() : null,
                                Status = reader["Status"] != DBNull.Value ? Convert.ToInt32(reader["Status"]) : 0,
                                CreatedDate = reader["CreatedDate"] != DBNull.Value ? Convert.ToDateTime(reader["CreatedDate"]) : DateTime.MinValue,
                                CreatedBy = reader["CreatedBy"] != DBNull.Value ? Convert.ToInt32(reader["CreatedBy"]) : 0,
                                ModifiedDate = reader["ModifiedDate"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(reader["ModifiedDate"]) : null,
                                ModifiedBy = reader["ModifiedBy"] != DBNull.Value ? (int?)Convert.ToInt32(reader["ModifiedBy"]) : null
                            };
                        }
                    }
                }
            }

            return user;
        }
    }
}
