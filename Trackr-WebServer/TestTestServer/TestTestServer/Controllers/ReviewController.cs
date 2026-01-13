using TestTestServer.Data;
using Microsoft.AspNetCore.Mvc;
using TestTestServer.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace TestTestServer.Controllers
{
    [ApiController]
    [Route("api/Review")]
    public class ReviewController : Controller
    {
        private readonly APIData dbContext;
        private readonly IConfiguration _configuration;
        public ReviewController(APIData dbContext, IConfiguration configuration)
        {
            this.dbContext = dbContext;
            _configuration = configuration;
        }
        // Lấy toàn bộ review
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            return Ok(await dbContext.Review.ToListAsync());
        }
        // post: tạo review mới
        [HttpPost]
        public async Task<IActionResult> Add(ReviewRequest request)
        {
            var review = new Review()
            {
                ParID = request.ParID,
                ReDescription = request.ReDescription,
                Star = request.Star,
            };
            await dbContext.Review.AddAsync(review);
            await dbContext.SaveChangesAsync();
            return Ok(review);
        }
        [HttpGet("Parcel")]
        public async Task<IEnumerable<Review>> GetParCel(int id)
        {
            var Reviews = new List<Review>();
            await
            using (var connection = new SqlConnection(_configuration.GetConnectionString("ApiDatabase")))
            {
                var sql = "SELECT ReID, ParID, ReDescription, Star FROM Review Where ParID = '" + id.ToString() + "'";
                connection.Open();
                using SqlCommand command = new SqlCommand(sql, connection);
                using SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    var review = new Review()
                    {  //
                        ReID = (int)reader["ReID"],
                        ParID = (int)reader["ParID"],
                        ReDescription = reader["ReDescription"].ToString(),
                        Star = (int)reader["Star"]
                    };
                    Reviews.Add(review);
                }
            }
            return Reviews;
        }
    }
}
