using TestTestServer.Models;
namespace TestTestServer;

public class FileService
{
    public FileService()
    {
        // Tạo thư mục uploads nếu chưa có
        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "uploads");
        if (!Directory.Exists(uploadsFolder))
        {
            Directory.CreateDirectory(uploadsFolder);
        }
    }

    public async Task<BlobRequestDTo> UpLoadAsync(IFormFile blob)
    {
        BlobRequestDTo response = new BlobRequestDTo();
        
        // Lưu file vào thư mục local
        var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "uploads");
        var fileName = $"{Guid.NewGuid()}_{blob.FileName}"; // Thêm GUID để tránh trùng tên
        var filePath = Path.Combine(uploadsFolder, fileName);
        
        using (var stream = new FileStream(filePath, FileMode.Create))
        {
            await blob.CopyToAsync(stream);
        }

        response.status = "File Upload Successfully";
        response.Error = false;
        response.Blob.uri = $"https://localhost:7111/uploads/{fileName}";
        response.Blob.name = fileName;

        return response;
    }
}
