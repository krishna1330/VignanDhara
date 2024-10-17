using System;

namespace VignanDhara.Entities
{
    public class BookRequests
    {
        public int BookRequestId { get; set; }
        public int UserId { get; set; }
        public int BookId { get; set; }
        public DateTime RequestedDate { get; set; }
        public int RequestStatus { get; set; }
        public string RejectedReason { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}
