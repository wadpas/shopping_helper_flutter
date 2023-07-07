import { Component } from '@angular/core';

@Component({
  selector: 'app-shopping-list',
  template: `
    <div class="row">
      <div class="col-xs-10">
        <app-shopping-edit />
        <hr />
        <p>The list</p>
      </div>
    </div>
  `,
})
export class ShoppingListComponent {}
