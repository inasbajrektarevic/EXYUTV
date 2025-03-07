public interface IFileManager
{
    Task<string> UploadFileAsync(IFormFile file);
    void DeleteFile(string? filePath);
}