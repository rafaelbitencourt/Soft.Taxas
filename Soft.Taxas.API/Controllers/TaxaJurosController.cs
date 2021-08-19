using Microsoft.AspNetCore.Mvc;
using Soft.Taxas.Dominio;

namespace Soft.Taxas.API.Controllers
{
    [ApiController]
    [Route("taxajuros")]
    public class TaxaJurosController : ControllerBase
    {
        private readonly ITaxasService _taxasService;

        public TaxaJurosController(ITaxasService taxasService)
        {
            _taxasService = taxasService;
        }

        [HttpGet]
        public string RecuperarTaxaDeJuros() => 
            _taxasService.RecuperarTaxaDeJuros().ToString();
    }
}
