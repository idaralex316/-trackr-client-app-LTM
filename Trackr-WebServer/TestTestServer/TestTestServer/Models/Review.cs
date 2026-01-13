using System.ComponentModel.DataAnnotations;

namespace TestTestServer.Models
{
    public class Review
    {
        [Key]
        public int ReID { get; set; }
        public int ParID { get; set; }
        public string? ReDescription { get; set; }
        public int Star { get; set; }
    }
}
