app = angular.module('smart_management', ['smart-table'])

$(document).on 'page:load', ->
  angular.bootstrap $("[ng-app='#{app.name}']"), ['smart_management']

app.factory('RestManager', =>
  class RestManager
    @editableColumns = =>
      $("[ng-app='#{app.name}']").first().data('editable-columns').split(',')

    @visibleColumns = =>
      $("[ng-app='#{app.name}']").first().data('visible-columns').split(',')

    @pluralModelName = =>
      $("[ng-app='#{app.name}']").first().data('plural-model-name')

    @singularModelName = =>
      $("[ng-app='#{app.name}']").first().data('singular-model-name')
)

app.controller "sortCtrl", [
  "$scope"
  "$filter"
  "$http"
  "RestManager"
  (scope, filter, http, RestManager) ->
    window.scope = scope
    scope.callServer = (tableState) ->
      scope.rowCollection = []
      http.get("/#{RestManager.pluralModelName()}.json").success((data) =>
        numberOfPages = data.meta.total / tableState.pagination.number
        tableState.pagination.numberOfPages = Math.ceil(numberOfPages)

        modelName = data.meta.pluralModelName

        $.each data[modelName], (_, resource) ->
          addNewRow(resource.user)
      )

    scope.showEdit = (row) ->
      scope.editedRow = row
      scope.editedResource = JSON.parse(JSON.stringify(row.resource))

      openFormModal('edit')
      return

    scope.showNew = ->
      scope.editedResource = {}
      $.each RestManager.editableColumns(), (column) ->
        scope.editedResource[column] = ''

      openFormModal('new')
      return

    scope.submitEntry = ->
      if scope.editedResource["id"]
        http.put(
          "/#{RestManager.pluralModelName()}/#{scope.editedResource.id}.json",
           user: scope.editedResource
        ).success((resource) =>
          scope.editedRow.resource = resource
          $('#formModal').modal('hide')
        ).error( (result) ->
          showErrors result
        )
      else
        options = {}
        options[RestManager.singularModelName()] = scope.editedResource
        http.post("/#{RestManager.pluralModelName()}.json",
          user: scope.editedResource
        ).success((resource) =>
          addNewRow(resource)
          $('#formModal').modal('hide')
        ).error((result) ->
          showErrors result
        )

    scope.deleteEntry = (row) ->
      http.delete("/#{RestManager.pluralModelName()}/#{row.resource.id}.json").
        success( =>
          scope.rowCollection = _.filter(scope.rowCollection, (item) -> item != row)
        )

    openFormModal = (mode) ->
      $('#formModal').modal()
      $('#formModal form').removeAttr('action')
      if mode == 'edit'
        $('#formModalLabel').html("Edit #{scope.editedResource.id}")
      else
        $('#formModalLabel').html('Add a new')

    addNewRow = (resource) ->
      row = {}
      row.resource = resource
      row.editUrl = "/#{RestManager.pluralModelName}/#{resource.id}"
      scope.rowCollection.push(row)

    showErrors = (result) ->
      alert $.map(result.data.errors, (messages, fieldName) ->
        "#{fieldName} : #{messages.join()}"
      ).join('\n')
]
