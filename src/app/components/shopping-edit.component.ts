import {
  Component,
  ElementRef,
  EventEmitter,
  Output,
  ViewChild,
} from '@angular/core';
import { Ingredient } from '../models/ingredient.model';

@Component({
  selector: 'app-shopping-edit',
  template: `
    <div class="row">
      <div class="col-xs-12">
        <form>
          <div class="row">
            <div class="col-sm-4" form-group>
              <label for="name">Name</label>
              <input type="text" id="name" class="form-control" #namedInput />
            </div>
            <div class="col-sm-2" form-group>
              <label for="amount">Amount</label>
              <input
                type="number"
                id="amount"
                class="form-control"
                #amountInput
              />
            </div>
          </div>
          <div class="row" style="margin-top: 10px;">
            <div class="col-xs-12">
              <button
                class="btn btn-success"
                style="margin-right: 10px;"
                type="submit"
                (click)="onAddItem()"
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
export class ShoppingEditComponent {
  @ViewChild('namedInput') nameInputRef: ElementRef;
  @ViewChild('amountInput') amountInputRef: ElementRef;
  @Output() ingrAdded = new EventEmitter<Ingredient>();

  onAddItem() {
    const newIngredient = new Ingredient(
      this.nameInputRef.nativeElement.value,
      this.amountInputRef.nativeElement.value
    );
    this.ingrAdded.emit(newIngredient);
  }
}
