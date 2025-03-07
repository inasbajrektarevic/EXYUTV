using AutoMapper;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class ChannelsController : BaseCrudController<ChannelModel, ChannelUpsertModel, ChannelsSearchObject, IChannelsService>
    {
        private readonly IFileManager _fileManager;
        public ChannelsController(IChannelsService service, IFileManager fileManager, IMapper mapper, ILogger<ChannelsController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
            _fileManager = fileManager;
        }

        [HttpPost]
        public override async Task<IActionResult> Post([FromForm] ChannelUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                model.LogoFile = GetFormFile();
                if (model.LogoFile != null)
                {
                    model.LogoUrl = await _fileManager.UploadFileAsync(model.LogoFile);
                }
                var result = await Service.AddAsync(model, cancellationToken);
                return Ok(result);

            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return ValidationResult(e.Errors);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return BadRequest();
            }
        }

        [HttpPut]
        public override async Task<IActionResult> Put([FromForm] ChannelUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                model.LogoFile = GetFormFile();
                if (model.LogoFile != null)
                {
                    model.LogoUrl = await _fileManager.UploadFileAsync(model.LogoFile);
                }
                return Ok(await Service.UpdateAsync(model));
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return ValidationResult(e.Errors);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return BadRequest();
            }
        }
    }
}
