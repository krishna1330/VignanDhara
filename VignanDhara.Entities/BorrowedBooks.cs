using System;

namespace VignanDhara.Entities
{
    public class BorrowedBooks
    {
        public int BorrowedBookId { get; set; }
        public int BookRequestId { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public bool IsReturned { get; set; }
        public DateTime ReturnedDate { get; set; }
        public int BookCollectedBy { get; set; }
    }
}
