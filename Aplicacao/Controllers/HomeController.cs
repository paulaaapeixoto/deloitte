using Aplicacao.Models;
using Modelo;
using Negocio;
using NPOI.HSSF.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;

namespace Aplicacao.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {

            List<NotaFiscal> notas = new List<NotaFiscal>();
            notas = NotaFiscalNeg.Listar();

            return View(notas);
        }
        public ActionResult CriarNota(NotaFiscal nota)
        {
            if (nota.Produto == null)
            {
                ViewBag.Clientes = new SelectList(ClienteNeg.Listar(), "Codigo", "Nome");

                ViewBag.Produtos = new SelectList(ProdutoNeg.Listar(), "Codigo", "Nome");

                return View(nota);
            }
            else
            {

                if (nota.Produto.Codigo > 0)
                {
                    nota.Produto = ProdutoNeg.Buscar(nota.Produto.Codigo);
                    nota.Itens = new List<Item>();

                    Item item = new Item();
                    item.Produto = nota.Produto;
                    item.Quantidade = nota.Quantidade;
                    nota.Itens.Add(item);

                    nota.ValorTotal = nota.Produto.Preco * nota.Quantidade;
                }



                NotaFiscalNeg.Incluir(nota);

                return RedirectToAction("Index");
            }

        }

        public ActionResult EditarNota(NotaFiscal nota)
        {
            if (nota.Produto == null)
            {
                ViewBag.Clientes = new SelectList(ClienteNeg.Listar(), "Codigo", "Nome");
                ViewBag.Produtos = new SelectList(ProdutoNeg.Listar(), "Codigo", "Nome");
                NotaFiscal nota3 = NotaFiscalNeg.Buscar(nota.Codigo);
                nota3.Produto = new Produto();
                nota3.Produto = nota3.Itens[0].Produto;
                nota3.Quantidade = nota3.Itens[0].Quantidade;

                return View(nota3);
            }
            else
            {
                if (nota.Produto.Codigo > 0)
                {
                    nota.Produto = ProdutoNeg.Buscar(nota.Produto.Codigo);
                    nota.Itens = new List<Item>();

                    Item item = new Item();
                    item.Produto = nota.Produto;
                    item.Quantidade = nota.Quantidade;
                    nota.Itens.Add(item);

                    nota.ValorTotal = nota.Produto.Preco * nota.Quantidade;
                }

                NotaFiscalNeg.Atualizar(nota);

                return RedirectToAction("Index");
            }
          
        }

        public ActionResult DeletarNota(int Codigo)
        {
            bool excluido = NotaFiscalNeg.Excluir(Codigo);

            return RedirectToAction("Index");
        }

        /// <summary>
        /// Consultar nota
        /// </summary>
        /// <param name="Codigo"></param>
        /// <returns></returns>
        public ActionResult DetalharNota(int Codigo)
        {
            NotaFiscal nota = NotaFiscalNeg.Buscar(Codigo);

            List<ListaProdutoAux> itens = new List<ListaProdutoAux>();

            foreach (Item item in nota.Itens)
            {
                itens.Add(new ListaProdutoAux() { Nome = item.Produto.Nome, Quantidade = item.Quantidade, Preco = item.Produto.Preco });
            }

            System.Web.UI.WebControls.GridView gView = new System.Web.UI.WebControls.GridView();
            gView.DataSource = itens;
            gView.DataBind();
            using (System.IO.StringWriter sw = new System.IO.StringWriter())
            {
                using (System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw))
                {
                    gView.RenderControl(htw);
                    ViewBag.GridViewString = sw.ToString();
                }
            }
            return View(nota);
        }

        public ActionResult GerarRelatorio()
        {

            try
            {
                List<Item> lista = NotaFiscalNeg.RelatorioTotalVendas();

                if (lista.Count > 0)
                {
                    // Cria um Woorkbook e uma página
                    var workbook = new HSSFWorkbook();
                    var sheet = workbook.CreateSheet("NFe Vendas");

                    #region "Headers"
                    // Adiciona os headers
                    var rowIndex = 0;
                    var cellIndex = 0;

                    var row = sheet.CreateRow(rowIndex);
                    row.CreateCell(cellIndex).SetCellValue("Codigo");
                    row.CreateCell(++cellIndex).SetCellValue("Nome");
                    row.CreateCell(++cellIndex).SetCellValue("Quantidade");
                    row.CreateCell(++cellIndex).SetCellValue("Total");


                    rowIndex++;
                    #endregion Headers"

                    #region "Preenchimento da lista"

                    lista.ForEach(resultado =>
                    {
                        var index = 0;
                        row = sheet.CreateRow(rowIndex);
                        row.CreateCell(index).SetCellValue(resultado.Produto.Codigo);

                        row.CreateCell(++index).SetCellValue(resultado.Produto.Nome);
                        row.CreateCell(++index).SetCellValue(resultado.Quantidade);

                        decimal valortotal = resultado.Quantidade * resultado.Produto.Preco;

                        row.CreateCell(++index).SetCellValue(valortotal.ToString());

                        rowIndex++;

                    });
                    #endregion 

                    string base64File = null;
                    using (var exportData = new MemoryStream())
                    {
                        workbook.Write(exportData);
                        // Converte o byte array p/ base64 p retornar na API
                        base64File = Convert.ToBase64String(exportData.GetBuffer());
                    }
                    byte[] bytes = Convert.FromBase64String(base64File);
                    return File(bytes, "application/excel", "Relatorio.xls");
                }

                return null;


            }
            catch (Exception exp)
            {
                throw exp;
            }


        }


    }
}