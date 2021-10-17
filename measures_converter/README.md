# Measured Converter
A real-time mass converter application.

The app mainly includes:
- Filling a `DropdownButton` from a `Map<String, double>`.
- A `TextField` input with a custom listener on its controller. 
- A `Text` result that updates in **real-time**

The main takeaway here how the result is updated on **dropdown** changes. The way it's done is by having a `calculateResult` function that returns the new converted value which is then used in `setState` in the `onChanged` method of the dropdown **after** updating the dropdown value. [Here's what I mean.](https://github.com/usersina/demo-flutter-apps/blob/main/measures_converter/lib/main.dart#L108)

<div align="center">

![](/media/measures-converter.png)
</div>