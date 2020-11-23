using System;
using System.Collections.Generic;

namespace Modelo
{
    public class NotaFiscal
    {
        public int Codigo { get; set; }
        public decimal ValorTotal { get; set; }
        public Cliente Cliente { get; set; }
        public List<Item> Itens { get; set; }
        public DateTime Data { get; set; }

        public Produto Produto { get; set; }

        public int Quantidade { get; set; }
    }
}
