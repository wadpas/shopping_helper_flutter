import { Component, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'app-header',
  template: `
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">Shopping helper</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="#" (click)="onSelect('recipes')">Recipes</a></li>
            <li>
              <a href="#" (click)="onSelect('shoppingList')">Shopping list</a>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" role="button"
                >Manage <span class="caret"></span
              ></a>
              <ul class="dropdown-menu">
                <li><a href="#">Save Data</a></li>
                <li><a href="#">Fetch Data</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  `,
})
export class HeaderComponent {
  @Output() featureSelected = new EventEmitter<string>();

  onSelect(feature: string) {
    this.featureSelected.emit(feature);
  }
}
