using System;

namespace VignanDhara.Entities
{
    public class Books
    {
        public int BookId { get; set; }
        public string BookName { get; set; }
        public string BookDescription { get; set; }
        public string Author { get; set; }
        public string ISBN { get; set; }
        public DateTime? PublishedDate { get; set; }
        public string Publisher { get; set; }
        public string Genre { get; set; }
        public int TotalBooks { get; set; }
        public int AvailableBooks { get; set; }
        public decimal? Rating { get; set; }
        public int Status { get; set; }
        public DateTime CreatedDate { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? ModifiedBy { get; set; }
    }
}
