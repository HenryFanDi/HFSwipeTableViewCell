# HFSwipeTableViewCell

SwipeTableViewCell with custom swipe button(s) and swipe button width(s).

## Usage

Extend `HFSwipeTableViewCell`.

```swift
class CustomTableViewCell: HFSwipeTableViewCell
```

Setup with right swipe button(s) and swipe button width(s).

```swift
func setRightSwipeButtons(rightSwipeBtns: [HFSwipeButton], btnWidths: [CGFloat])
```

### TableView

Setup above method to `tableView:cellForRowAtIndexPath`.

```swift
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	let customTableViewCell = tableView.dequeueReusableCellWithIdentifier(CustomCellReuseIdentifier) as? CustomTableViewCell
	
	customTableViewCell?.setRightSwipeButtons([
      HFSwipeButton.init(swipeButtonType: .HFSwipeButtonDial)
      ], btnWidths: [50.0])
	...
	
	return customTableViewCell!
  }
```

### HFSwipeButton

Setup custom swipe button configuration by custom type.

```swift
private func setupSwipeButtonWithSwipeButtonType() {
	...
	switch swipeButtonType {
	case .CustomType:
		swipeImageSize = 50.0
		btnBackgroundColor = .lightGrayColor()
		imageNamed = "Custom"
		break
	default:
		break
	}
	...
}
```

1. Add new custom type to ```HFSwipeButtonType```.

	```swift
	enum HFSwipeButtonType {
		case CustomType
		...
	}
	```

2. Setup properties.

	* `swipeImageSize: CGFloat` － Image size, setup if needed, default is 20.0
	* `btnBackgroundColor: UIColor` － Button background color
	* `imageNamed: String` － Image name

## Feature

* Left swipe behavior, lol.

## License

This project is under MIT License. Please feel free to use.

## Contact

If have any suggestions or improvements, welcome feel free to contact me at [@HenryFanDi](https://twitter.com/HenryHaoTi).