# HFSwipeTableViewCell

SwipeTableViewCell with custom swipe button(s) and swipe button width(s).

![alt tag](https://raw.githubusercontent.com/HenryFanDi/HFSwipeTableViewCell/develop/demo.gif =320x564)

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
      swipeButton(swipeButtonType: .CustomType)
      ], btnWidths: [50.0])
	...
	
	return customTableViewCell!
  }
```

Init `HFSwipeButton` by custom type.

```swift
private func swipeButton(swipeButtonType swipeButtonType: HFSwipeButtonType) -> HFSwipeButton {
	let swipeButton = HFSwipeButton.init(swipeButtonType: swipeButtonType)
	swipeButton.delegate = self
	return swipeButton
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
		btnBackgroundColor = .init(red: 255.0/255.0, green: 198.0/255.0, blue: 26.0/255.0, alpha: 1.0)
		imageNamed = "Custom"
		addTarget(self, action: #selector(HFSwipeButton.customBtnOnTap), forControlEvents: .TouchUpInside)
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

	* `swipeImageSize: CGFloat` － Image size, setup if needed, default is 20.0.
	* `btnBackgroundColor: UIColor` － Button background color.
	* `imageNamed: String` － Image name.
	* `addTarget:action:forControlEvents` － Implement its on tap event and pass event with delegate.

		```swift
		func customBtnOnTap() {
			delegate?.customBtnOnTap()
		}
		```

## Feature

* Left swipe behavior, lol.

## License

This project is under MIT License. Please feel free to use.

## Contact

If have any suggestions or improvements, welcome feel free to contact me at [@HenryFanDi](https://twitter.com/HenryHaoTi).