using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using VignanDhara.Entities;

namespace VignanDhara.Data
{
    public class BooksDAC
    {
        public List<Books> GetAllBooks(string conStr)
        {
            List<Books> books = new List<Books>();

            using (SqlConnection connection = new SqlConnection(conStr))
            {
                using (SqlCommand command = new SqlCommand("spGetAllBooks", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Books book = new Books
                            {
                                BookId = reader.GetInt32(reader.GetOrdinal("BookId")),
                                BookName = reader.GetString(reader.GetOrdinal("BookName")),
                                BookDescription = reader.IsDBNull(reader.GetOrdinal("BookDescription")) ? null : reader.GetString(reader.GetOrdinal("BookDescription")),
                                Author = reader.IsDBNull(reader.GetOrdinal("Author")) ? null : reader.GetString(reader.GetOrdinal("Author")),
                                ISBN = reader.IsDBNull(reader.GetOrdinal("ISBN")) ? null : reader.GetString(reader.GetOrdinal("ISBN")),
                                PublishedDate = reader.IsDBNull(reader.GetOrdinal("PublishedDate")) ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("PublishedDate")),
                                Publisher = reader.IsDBNull(reader.GetOrdinal("Publisher")) ? null : reader.GetString(reader.GetOrdinal("Publisher")),
                                Genre = reader.IsDBNull(reader.GetOrdinal("Genre")) ? null : reader.GetString(reader.GetOrdinal("Genre")),
                                TotalBooks = reader.GetInt32(reader.GetOrdinal("TotalBooks")),
                                AvailableBooks = reader.GetInt32(reader.GetOrdinal("AvailableBooks")),
                                Rating = reader.IsDBNull(reader.GetOrdinal("Rating")) ? (decimal?)null : reader.GetDecimal(reader.GetOrdinal("Rating")),
                                Status = reader.GetInt32(reader.GetOrdinal("Status")),
                                CreatedDate = reader.GetDateTime(reader.GetOrdinal("CreatedDate")),
                                CreatedBy = reader.IsDBNull(reader.GetOrdinal("CreatedBy")) ? (int?)null : reader.GetInt32(reader.GetOrdinal("CreatedBy")),
                                ModifiedDate = reader.IsDBNull(reader.GetOrdinal("ModifiedDate")) ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("ModifiedDate")),
                                ModifiedBy = reader.IsDBNull(reader.GetOrdinal("ModifiedBy")) ? (int?)null : reader.GetInt32(reader.GetOrdinal("ModifiedBy")),
                            };

                            books.Add(book);
                        }
                    }
                }
            }

            return books;
        }

        public int AddBook(string conStr, Books book)
        {
            using (SqlConnection connection = new SqlConnection(conStr))
            {
                using (SqlCommand command = new SqlCommand("spAddBook", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@BookName", book.BookName);
                    command.Parameters.AddWithValue("@BookDescription", book.BookDescription);
                    command.Parameters.AddWithValue("@Author", book.Author);
                    command.Parameters.AddWithValue("@ISBN", book.ISBN);
                    command.Parameters.AddWithValue("@PublishedDate", book.PublishedDate ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Publisher", book.Publisher);
                    command.Parameters.AddWithValue("@Genre", book.Genre);
                    command.Parameters.AddWithValue("@TotalBooks", book.TotalBooks);
                    command.Parameters.AddWithValue("@AvailableBooks", book.AvailableBooks);
                    command.Parameters.AddWithValue("@Rating", book.Rating ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@CreatedBy", book.CreatedBy);

                    connection.Open();

                    int bookId = Convert.ToInt32(command.ExecuteScalar());
                    return bookId;
                }
            }
        }

        public int DeleteBookByBookId(string conStr, int bookId, int modifiedBy)
        {
            int result = 0;

            using (SqlConnection connection = new SqlConnection(conStr))
            {
                using (SqlCommand command = new SqlCommand("spDeleteBookByBookId", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@BookId", bookId);
                    command.Parameters.AddWithValue("@ModifiedBy", modifiedBy);

                    SqlParameter outputParameter = new SqlParameter();
                    outputParameter.ParameterName = "@Result";
                    outputParameter.SqlDbType = SqlDbType.Int;
                    outputParameter.Direction = ParameterDirection.Output;
                    command.Parameters.Add(outputParameter);

                    connection.Open();

                    command.ExecuteNonQuery();

                    result = (int)command.Parameters["@Result"].Value;
                }
            }

            return result;
        }

        public string RequestBook(string conStr, int userId, int bookId)
        {
            string resultMessage;

            using (SqlConnection connection = new SqlConnection(conStr))
            {
                using (SqlCommand command = new SqlCommand("spRequestBook", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@userId", userId);
                    command.Parameters.AddWithValue("@bookId", bookId);

                    try
                    {
                        connection.Open();

                        resultMessage = (string)command.ExecuteScalar();
                    }
                    catch (Exception ex)
                    {
                        resultMessage = "Error: " + ex.Message;
                    }
                }
            }

            return resultMessage;
        }

        public DataTable GetMyBooks(string conStr, int userId)
        {
            DataTable booksTable = new DataTable();

            using (SqlConnection connection = new SqlConnection(conStr))
            {
                using (SqlCommand command = new SqlCommand("spGetMyBooks", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@userId", userId);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            booksTable.Load(reader);
                        }
                    }
                    catch (SqlException ex)
                    {
                        Console.WriteLine("SQL Error: " + ex.Message);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                    }
                }
            }

            return booksTable;
        }

        public DataTable GetBookRequests(string conStr)
        {
            DataTable bookRequestsTable = new DataTable();

            using (SqlConnection connection = new SqlConnection(conStr))
            {
                using (SqlCommand command = new SqlCommand("spGetBookRequests", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    connection.Open();

                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(bookRequestsTable);
                    }
                }
            }

            return bookRequestsTable;
        }
    }
}
