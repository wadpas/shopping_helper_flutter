import { Component } from '@angular/core';

@Component({
  selector: 'app-shopping-edit',
  template: `
    <div class="row">
      <div class="col-xs-12">
        <form>
          <div class="row">
            <div class="col-sm-4" form-group>
              <label for="name">Name</label>
              <input type="text" id="name" class="form-control" />
            </div>
            <div class="col-sm-2" form-group>
              <label for="amount">Amount</label>
              <input type="number" id="amount" class="form-control" />
            </div>
          </div>
          <div class="row" style="margin-top: 10px;">
            <div class="col-xs-12">
              <button
                class="btn btn-success"
                style="margin-right: 10px;"
                type="submit"
              >
                Add
              </button>
              <button
                class="btn btn-danger"
                style="margin-right: 10px;"
                type="button"
              >
                Delete
              </button>
              <button class="btn btn-primary" type="button">Clear</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  `,
})
export class ShoppingEditComponent {}
