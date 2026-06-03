# run-app.ps1
# ============================================
# ดาวน์โหลดและรันไฟล์ EXE จาก GitHub
# ============================================

# 🔧 แก้ไข URL นี้ให้ตรงกับลิงก์ที่คุณโหลดได้
$ลิงก์ดาวน์โหลด = "https://github.com/auden131313/fvvvie33333333333/releases/download/v1.0/allleawewaeaw.exe"

# ส่วนนี้ไม่ต้องแก้
$ไฟล์ชั่วคราว = "$env:TEMP\temp_$(Get-Random).exe"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   เริ่มต้นทำงาน" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "📥 กำลังดาวน์โหลดจาก GitHub..." -ForegroundColor Yellow

try {
    # ดาวน์โหลดไฟล์
    Invoke-WebRequest -Uri $ลิงก์ดาวน์โหลด -OutFile $ไฟล์ชั่วคราว -UseBasicParsing
    Write-Host "✅ ดาวน์โหลดสำเร็จ!" -ForegroundColor Green
    Write-Host "💾 ไฟล์ชั่วคราว: $ไฟล์ชั่วคราว" -ForegroundColor Gray
    
    # ตรวจสอบขนาดไฟล์ (optional)
    $ขนาด = [math]::Round((Get-Item $ไฟล์ชั่วคราว).Length / 1MB, 2)
    Write-Host "📊 ขนาดไฟล์: $ขนาด MB" -ForegroundColor Cyan
    Write-Host ""
    
    # รันโปรแกรม
    Write-Host "▶️ กำลังรันโปรแกรม..." -ForegroundColor Yellow
    Write-Host "   (โปรแกรมจะทำงาน รอจนกว่าจะปิด)" -ForegroundColor Gray
    Start-Process -FilePath $ไฟล์ชั่วคราว -Wait
    
    Write-Host ""
    Write-Host "✅ โปรแกรมทำงานเสร็จ!" -ForegroundColor Green
    
} catch {
    Write-Host ""
    Write-Host "❌ เกิดข้อผิดพลาด!" -ForegroundColor Red
    Write-Host "❗ สาเหตุ: $($_.Exception.Message)" -ForegroundColor Red
    
} finally {
    # ลบไฟล์ชั่วคราว
    if (Test-Path $ไฟล์ชั่วคราว) {
        Remove-Item $ไฟล์ชั่วคราว -Force
        Write-Host ""
        Write-Host "🗑️ ลบไฟล์ชั่วคราวเรียบร้อย" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   เสร็จสิ้น" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "กดปุ่มใดๆ เพื่อปิดหน้าต่างนี้..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")