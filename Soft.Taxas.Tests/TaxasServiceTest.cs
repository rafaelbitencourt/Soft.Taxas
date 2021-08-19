using Soft.Taxas.Dominio;
using Xunit;

namespace Taxas.Tests
{
    public class TaxasServiceTest
    {
        [Fact]
        public void RecuperarTaxaDeJuros_RetornaUmPorcento()
        {
            var mockTaxasService = new TaxasService();

            var resultado = mockTaxasService.RecuperarTaxaDeJuros();

            Assert.Equal(0.01m, resultado);
        }
    }
}
