local WaveUILib = {}

local function createFrame(parent, size, position)
	local frame = Instance.new("Frame")
	frame.Size = size
	frame.Position = position
	frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	frame.BorderSizePixel = 0
	frame.Parent = parent
	return frame
end

function WaveUILib:CreateWindow(title)
	local ScreenGui = Instance.new("ScreenGui")
	local MainFrame = createFrame(ScreenGui, UDim2.new(0, 400, 0, 300), UDim2.new(0.5, -200, 0.5, -150))

	local TopBar = createFrame(MainFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0))
	TopBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -30, 1, 0)
	Title.Position = UDim2.new(0, 5, 0, 0)
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	local CloseButton = Instance.new("TextButton")
	CloseButton.Size = UDim2.new(0, 30, 0, 30)
	CloseButton.Position = UDim2.new(1, -30, 0, 0)
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
	CloseButton.Parent = TopBar

	local ContentFrame = createFrame(MainFrame, UDim2.new(1, 0, 1, -30), UDim2.new(0, 0, 0, 30))

	CloseButton.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	ScreenGui.Parent = game.CoreGui

	return {
		ContentFrame = ContentFrame,
		ScreenGui = ScreenGui
	}
end

function WaveUILib:CreateTab(parent, tabName)
	local TabButton = Instance.new("TextButton")
	TabButton.Size = UDim2.new(0, 100, 0, 30)
	TabButton.Text = tabName
	TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TabButton.Parent = parent

	local TabFrame = createFrame(parent.Parent, UDim2.new(1, 0, 1, -30), UDim2.new(0, 0, 0, 30))
	TabFrame.Visible = false

	TabButton.MouseButton1Click:Connect(function()
		for _, child in pairs(parent:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			end
		end
		TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		for _, frame in pairs(parent.Parent:GetChildren()) do
			if frame:IsA("Frame") and frame ~= parent then
				frame.Visible = false
			end
		end
		TabFrame.Visible = true
	end)

	return TabFrame
end

function WaveUILib:CreateDropdown(parent, options, defaultText)
	local DropdownButton = Instance.new("TextButton")
	DropdownButton.Size = UDim2.new(1, 0, 0, 30)
	DropdownButton.Text = defaultText or "Select an option"
	DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	DropdownButton.Parent = parent

	local DropdownFrame = createFrame(parent, UDim2.new(1, 0, 0, #options * 30), UDim2.new(0, 0, 0, 30))
	DropdownFrame.Visible = false

	DropdownButton.MouseButton1Click:Connect(function()
		DropdownFrame.Visible = not DropdownFrame.Visible
	end)

	for i, option in ipairs(options) do
		local OptionButton = Instance.new("TextButton")
		OptionButton.Size = UDim2.new(1, 0, 0, 30)
		OptionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
		OptionButton.Text = option
		OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		OptionButton.Parent = DropdownFrame

		OptionButton.MouseButton1Click:Connect(function()
			DropdownButton.Text = option
			DropdownFrame.Visible = false
		end)
	end

	return DropdownButton
end

function WaveUILib:CreateButton(parent, buttonText, callback)
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, 0, 0, 30)
	Button.Text = buttonText
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Button.Parent = parent

	Button.MouseButton1Click:Connect(function()
		callback()
	end)

	return Button
end

function WaveUILib:CreateDivider(parent)
	local Divider = Instance.new("Frame")
	Divider.Size = UDim2.new(1, 0, 0, 2)
	Divider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	Divider.Parent = parent

	return Divider
end

return WaveUILib
