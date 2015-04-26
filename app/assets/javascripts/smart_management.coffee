app = angular.module('smart_management', ['smart-table'])

$(document).on 'page:load', ->
  angular.bootstrap $("[ng-app='#{app.name}']"), ['smart_management']

app.factory('RestManager', =>
  class RestManager
    @pluralModelName = =>
      $("[ng-app='#{app.name}']").first().data('plural-model-name')
)

app.controller "sortCtrl", [
  "$scope"
  "$filter"
  "$http"
  "RestManager"
  (scope, filter, http, RestManager) ->
    window.scope = scope
    scope.new_path = "/#{RestManager.pluralModelName()}/new"
    scope.callServer = (tableState) ->
      scope.rowCollection = []
      http.get("/#{RestManager.pluralModelName()}.json", params: tableState).
        success((data) =>
          numberOfPages = data.meta.total / tableState.pagination.number
          tableState.pagination.numberOfPages = Math.ceil(numberOfPages)
          $.each data.items, (_, resource) ->
            scope.addNewRow(resource)
        )

    scope.deleteEntry = (row) ->
      http.delete("/#{RestManager.pluralModelName()}/#{row.resource.id}.json").
        success( =>
          scope.rowCollection = _.filter(scope.rowCollection,
            (item) -> item != row)
        )

    scope.addNewRow = (resource) ->
      row = {}
      row.resource = resource
      row.editUrl = "/#{RestManager.pluralModelName()}/#{resource.id}/edit"
      scope.rowCollection.push(row)
      scope.$apply() unless scope.$$phase

    scope.updateRow = (resource) ->
      $.each scope.rowCollection, (_, row) ->
        if row.resource.id == resource.id
          row.resource = resource
      scope.$apply() unless scope.$$phase
]

app.directive "managerRow", ->
  replace: true
  template: $('#row').text()
