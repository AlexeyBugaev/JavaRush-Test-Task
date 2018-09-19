<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="from" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>PartsList</title>
    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .paging{
            display: inline-block;
            padding: 3px;
        }
        .input{
            background-color: #ffc;
            color: #000;
        }
    </style>
</head>

<body class="body">
<c:if test="${(partFound==null)&&showInEdit}">
<h2>Список комплектующих на складе</h2>
</c:if>
<c:if test="${partFound!=null}">
    <h2>Данные по детали ${partFound.name}</h2>
</c:if>
<!Добавление URL контроллера на обработку пейджинга страниц и сортировки компонентов>

<c:url var="back" value="/parts/back"/>
<c:url var="next" value="/parts/next"/>
<c:url var="sortParts" value="/parts/sort"/>

<!Таблица навигации по страницам и сортировки>

<c:if test="${!deleted}">
<c:if test="${(partFound==null)&&showInEdit}">
<table class="header">
    <tr>
        <td width="200" align="left"><h4>Стр ${currentPage} из ${pages}</h4></td>
        <td width="100"></td>
        <td width="100" align="center"><h4>Сортировка</h4></td>
        <td width="100"></td>
        <td width="100"></td>
    </tr>

<!Добавление в таблицу кнопок навигации по страницам>

    <tr>
        <td width="200" align="left">
            <form:form action="${back}" cssClass="paging">
                <c:if test="${currentPage>1}">
                    <input type="submit" class="input"
                           value="<spring:message text="Назад"/>"/>
                </c:if>
            </form:form>
            <form:form action="${next}" cssClass="paging">
                <c:if test="${currentPage<pages}">
                    <input type="submit" class="input"
                           value="<spring:message text="Вперед"/>"/>
                </c:if>
            </form:form>
        </td>

<!Добавление в таблицу формы сортировки>

        <form:form action="${sortParts}">
        <td width="100" align="center">
                    <label><input name="sort" type="radio" checked="checked"
                           value="${sort="all"}"/>Все</label>
        </td>
        <td width="100" align="center">
                    <label><input name="sort" type="radio"
                           value="${sort="required"}"/>Базовые</label>
        </td>
        <td width="100" align="center">
                <label><input name="sort" type="radio"
                              value="${sort="optional"}"/>Опции</label>
        </td>
        <td width="100" align="center">
                    <input type="submit" class="input"
                           value="<spring:message text="Выбрать"/>"/>
        </td>
        </form:form>
    </tr>
</table>
</c:if>

<!Таблица с данными>

<table class="tg">
    <tr>
        <th width="120">Наименование</th>
        <th width="120">Потребность</th>
        <th width="120">Количество</th>
        <th width="120">Редактировать</th>
        <th width="120">Удалить</th>
    </tr>

<!Вывод списка деталей в таблицу>

    <c:forEach items="${listParts}" var="part">
        <tr>
            <td>${part.name}</td>
            <c:if test="${part.need}"><td align="center">Да</td></c:if>
            <c:if test="${!part.need}"><td align="center">Нет</td></c:if>
            <td align="center">${part.quantity}</td>
            <td><a href="<c:url value='/edit/${part.id}'/>">Изменить</a> </td>
            <td><a href="<c:url value='/remove/${part.id}'/>">Удалить</a> </td>
        </tr>
    </c:forEach>
</table

<br/>
<br/>

<!Количество компьютеров, готовых для сборки>
<c:if test="${partFound==null}">
<c:if test="${showInEdit}">
<table class="tg">
        <tr>
            <td width="120">Можно собрать</td>
            <td width="120" align="center">${ready}</td>
            <td width="120">компьютеров</td>
        </tr>
</table>
</c:if>
<!Форма для добавления и изменения деталей>

<c:url var="addAction" value="/parts/add"/>

<form:form action="${addAction}" modelAttribute="part">
    <c:if test="${!empty part.name}">
        <h2>Изменить деталь на складе</h2>
    </c:if>
    <c:if test="${empty part.name}">
        <h2>Добавить деталь на склад</h2>
    </c:if>

    <table>
        <c:if test="${!empty part.name}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="Номер"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="name">
                    <spring:message text="Наименование"/>
                </form:label>
            </td>
            <td>
                <form:input path="name"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="need">
                    <spring:message text="Потребность"/>
                </form:label>
            </td>
            <td>
                <form:input path="need"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="quantity">
                    <spring:message text="Количество"/>
                </form:label>
            </td>
            <td>
                <form:input path="quantity"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <c:if test="${!empty part.name}">
                    <input type="submit" class="input"
                           value="<spring:message text="Изменить деталь"/>"/>
                </c:if>
                <c:if test="${empty part.name}">
                    <input type="submit" class="input"
                           value="<spring:message text="Добавить деталь"/>"/>
                </c:if>
            </td>
        </tr>
    </table>

<!Кнопка отмены изменения>
    <c:if test="${!empty part.name}">
        <c:url var="cancel" value="/parts/add"/>

        <form:form action="${cancel}">

            <input type="submit" class="input"
                   value="<spring:message text="Отмена"/>"/>

        </form:form>
    </c:if>
</form:form>

<c:if test="${showInEdit}">
<h2>Поиск детали по наименованию</h2>
<c:url var="search" value="/parts/partData"/>
<form:form action="${search}" method="get" modelAttribute="lookFor" cssClass="paging">
        <input type="text" name="name"/>
        <input type="submit" class="input"
               value="<spring:message text="Найти"/>"/>
</form:form>
</c:if>
</c:if>
</c:if>

<c:if test="${deleted}">
    <h4>Деталь ${partFound.name} удалена</h4>
</c:if>
<c:if test="${changed}">
    <h4>Деталь ${partFound.name} изменена</h4>
</c:if>
</br>
<c:if test="${partFound!=null}">
<a href="<c:url value="/parts/return"/>">Вернуться к списку комплектующих</a>
</c:if>
<c:if test="${partFound==null}">
    <a href="../../index.jsp">Вернуться в главное меню</a>
</c:if>

</body>
</html>