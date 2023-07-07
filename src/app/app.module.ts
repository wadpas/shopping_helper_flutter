import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HeaderComponent } from './components/header.component';
import { RecipesComponent } from './screens/recipes.component';
import { RecipeDetailsComponent } from './components/recipe-details.component';
import { RecipeItemComponent } from './components/recipe-item.component';
import { RecipeListComponent } from './components/recipe-list.component';
import { ShoppingListComponent } from './screens/shopping-list.component';
import { ShoppingEditComponent } from './components/shopping-edit.component';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    RecipesComponent,
    RecipeListComponent,
    RecipeDetailsComponent,
    RecipeItemComponent,
    ShoppingListComponent,
    ShoppingEditComponent,
  ],
  imports: [BrowserModule, AppRoutingModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
