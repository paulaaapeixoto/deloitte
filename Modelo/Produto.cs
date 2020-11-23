namespace Modelo
{
    public class Produto
    {
        public int Codigo { get; set; }
        public string Nome { get; set; }

        public decimal Preco { get; set; }

        public Fornecedor Fornecedor { get; set; }
    }
}
