<%--
    Document   : index
    Created on : 27/08/2014
    Author     : Anderson
--%>
<%@page import="br.ufc.pet.evento.Participante"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.lang.Exception" %>
<%@page import="br.ufc.pet.evento.Atividade,br.ufc.pet.evento.Organizador,br.ufc.pet.evento.Organizacao,br.ufc.pet.evento.ResponsavelAtividade" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <%@include file="../ErroAutenticacaoUser.jsp" %>
    <head>      
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="../css/estilo.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
            function checkAllCheckboxes(){
                var aux = 1;
                for (var i=0;i<document.formVerificarAluno.elements.length;i++) {
                    if(document.formVerificarAluno.elements[i].type == 'checkbox') {
                        aux = document.formVerificarAluno.elements[i].checked;
                        break;
                    }
                }
                for (var i=0;i<document.formVerificarAluno.elements.length;i++) {
                    if(document.formVerificarAluno.elements[i].type == 'checkbox') {
                        document.formVerificarAluno.elements[i].checked = aux;
                    }
                }
            }
        </script>
        <title>Centro de Controle :: Organizador</title>
    </head>
    
    
    <body>
        <%
                    br.ufc.pet.evento.Evento e = (br.ufc.pet.evento.Evento) session.getAttribute("evento");
                    Organizador organizador = (Organizador) session.getAttribute("user");
                    ArrayList<Atividade> ats = e.getAtividades();
                    
                    ArrayList<Participante> parts = (ArrayList) session.getAttribute("participantes");
                    Long idAtividade = 0L;
                    try{
                        idAtividade = (Long) session.getAttribute("ativ_id");
                        //System.out.println("TEMP: "+temp);
                       // idAtividade = Long.parseLong(temp);
                        
                    }catch(Exception e1){
                        System.out.println("Exception :: NULL");
                        idAtividade = 0L;
                    }
                    
        %>
        <div id="container">
            <div id="top">
                <%-- Incluindo o Menu --%>
                <%@include file="organ_menu.jsp"%>
            </div>
            <div id="content">
                <h1 class="titulo">Selecionar Participantes para Liberar Certificado</h1>
                <%@include file="/error.jsp" %>
                <%if (parts == null || parts.size() == 0) {%>
                <center><label>Sem participantes quites nesta atividade</label></center>
                <%} else {%>
                <form name="formVerificarAluno" action="../ServletCentral?comando=CmdConfirmarLiberacaoCertificado" class="confirmaCertificado" method="post" onsubmit="return confirm('Deseja realmente liberar os certificados para os participantes selecionados?');" >
                    <table>
                        <tr>
                            <th><input type="checkbox" onclick="checkAllCheckboxes();" /></th>
                            <th>Nome</th>
                            <th>Instituição</th>
                            <th>E-mail</th>
                        </tr>
                        <%for (Participante p : parts) {%>
                        <tr>
                            <td><input type="checkbox" name="verificaAluno" value="<%=p.getInscricaoByEvento(e.getId()).getId() %>" /></td>
                            <td><%=p.getUsuario().getNome() %></td>
                            <td><%=p.getUsuario().getInstituicao() %></td>
                            <td><%=p.getUsuario().getEmail() %></td>
                        </tr>
                        <%}%>
                    </table>
                    <input type="hidden" name="ativ_id" value="<%=idAtividade %>" />
                    <input type="submit" value="Liberar" class="button" />
                </form>
                <% }%>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
