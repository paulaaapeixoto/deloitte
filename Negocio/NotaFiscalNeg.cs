using Modelo;
using Repositorio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NotaFiscalNeg
    {
        public static List<NotaFiscal> Listar()
        {
            try
            {
                return NotaFiscalRep.Listar();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static bool Excluir(int codigo)
        {
            try
            {
                return NotaFiscalRep.Excluir(codigo);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static bool Atualizar(NotaFiscal nota)
        {
            try
            {
                bool atualizado = NotaFiscalRep.Atualizar(nota);

                if (atualizado)
                {
                    foreach (Item item in nota.Itens)
                    {
                        NotaFiscalRep.AtualizarItens(nota.Codigo, item);
                    }

                    return true;
                }

                return false;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static bool Incluir(NotaFiscal nota)
        {
            try
            {
                int incluido = NotaFiscalRep.Incluir(nota);

                if (incluido > 0)
                {
                    foreach (Item item in nota.Itens)
                    {
                        NotaFiscalRep.IncluirItens(incluido, item);
                    }

                    return true;
                }

                return false;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static NotaFiscal Buscar(int codigo)
        {
            try
            {
                NotaFiscal notafical = NotaFiscalRep.Buscar(codigo);
                notafical.Itens = BuscarItens(codigo);
                notafical.Cliente = ClienteNeg.Buscar(notafical.Cliente.Codigo);

                return notafical;

            }
            catch (Exception)
            {
                throw;
            }
        }

        private static List<Item> BuscarItens(int codigo)
        {
            try
            {
                List<Item> itens = new List<Item>();
                itens = NotaFiscalRep.BuscarItens(codigo);

                return itens;

            }
            catch (Exception)
            {
                throw;
            }
        }

        public static List<Item> RelatorioTotalVendas()
        {
            try
            {
                return NotaFiscalRep.RelatorioTotalVendas();
            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}
